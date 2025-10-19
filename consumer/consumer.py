import json
import pika
from rich.console import Console
from rich.json import JSON

# === CONFIGURAÇÕES ===
RABBITMQ_URL = "amqp://guest:guest@ip-da-aws:5672/" 
# Para testes locais - RABBITMQ_URL = "amqp://guest:guest@localhost:5672/" 
QUEUE_NAME = "beauty-barreto.queue"

console = Console()

def on_message(channel, method, properties, body):
    try:
        data = json.loads(body.decode())
        console.rule("[bold green]📩 Nova mensagem recebida")
        console.print(JSON.from_data(data))
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
