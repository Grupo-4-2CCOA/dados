import json
import pika
import mysql.connector
from rich.console import Console
from rich.json import JSON
from datetime import datetime

# === CONFIGURAÇÕES ===
RABBITMQ_URL = "amqp://guest:guest@ip-da-aws:5672/"
QUEUE_NAME = "beauty-barreto.queue"

DB_CONFIG = {
    "host": "localhost",
    "user": "infra",
    "password": "infra",
    "database": "grupo4"
}

console = Console()

# === BANCO DE DADOS ===
def salvar_agendamento(data):
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Inserir na tabela schedule
        cursor.execute("""
            INSERT INTO schedule (
                status, appointment_datetime, duration,
                transaction_hash, fk_client, fk_employee, fk_payment_type
            ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            data["status"],
            data["appointment_datetime"],
            data.get("duration"),
            data.get("transaction_hash"),
            data["fk_client"],
            data["fk_employee"],
            data.get("fk_payment_type")
        ))

        schedule_id = cursor.lastrowid

        # Inserir os itens na tabela schedule_item
        for item in data.get("items", []):
            cursor.execute("""
                INSERT INTO schedule_item (
                    final_price, discount, fk_schedule, fk_service
                ) VALUES (%s, %s, %s, %s)
            """, (
                item["final_price"],
                item.get("discount", 0),
                schedule_id,
                item["fk_service"]
            ))

        conn.commit()
        return schedule_id

    except mysql.connector.Error as err:
        console.print(f"[red]❌ Erro ao salvar no MySQL:[/red] {err}")
        return None
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

# === CONSUMER ===
def on_message(channel, method, properties, body):
    try:
        data = json.loads(body.decode())
        console.rule("[bold green]📩 Nova mensagem recebida")
        console.print(JSON.from_data(data))

        schedule_id = salvar_agendamento(data)
        if schedule_id:
            console.print(f"[bold blue]💾 Agendamento salvo com ID {schedule_id}.")
        else:
            console.print("[red]⚠️ Falha ao salvar agendamento.")

    except json.JSONDecodeError:
        console.print(f"[red]❌ Erro ao decodificar JSON:[/red] {body}")
    finally:
        channel.basic_ack(delivery_tag=method.delivery_tag)

def main():
    params = pika.URLParameters(RABBITMQ_URL)
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE_NAME, durable=True)

    console.print(f"✅ Aguardando mensagens da fila [bold cyan]{QUEUE_NAME}[/bold cyan]...\n")
    channel.basic_consume(queue=QUEUE_NAME, on_message_callback=on_message)

    try:
        channel.start_consuming()
    except KeyboardInterrupt:
        console.print("\n🛑 Interrompido pelo usuário.")
        channel.stop_consuming()
    finally:
        connection.close()

if __name__ == "__main__":
    main()