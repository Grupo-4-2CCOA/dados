import json
import pika
import mysql.connector
from rich.console import Console
from rich.json import JSON

# === CONFIGURAÇÕES ===
RABBITMQ_URL = "amqp://guest:guest@localhost:5672/"
QUEUE_NAME = "beauty-barreto.queue"

DB_CONFIG = {
    "host": "localhost",
    "user": "infra",
    "password": "infra",
    "database": "grupo4"
}

console = Console()

def salvar_feedback(data):
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Salvar feedback
        cursor.execute("""
            INSERT INTO feedback (
                rating, comment, fk_schedule
            ) VALUES (%s, %s, %s)
        """, (
            data["rating"],
            data.get("comment", ""),
            data["scheduleId"]
        ))
        conn.commit()
        feedback_id = cursor.lastrowid

        # Buscar e-mail e nome do cliente
        # cursor.execute("""
        #     SELECT u.name, u.email
        #     FROM schedule s
        #     JOIN user u ON u.id = s.fk_client
        #     WHERE s.id = %s
        # """, [data["scheduleId"]])
        # cliente = cursor.fetchone()

        # if cliente:
        #     nome_cliente, email_cliente = cliente
        #     enviar_email_agradecimento(
        #         destinatario=email_cliente,
        #         nome_cliente=nome_cliente,
        #         rating=data["rating"],
        #         comment=data.get("comment", "")
        #     )

        return feedback_id

    except mysql.connector.Error as err:
        console.print(f"[red] Erro ao salvar feedback no MySQL:[/red] {err}")
        return None
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


# def enviar_email_agradecimento(destinatario, nome_cliente, rating, comment):
#     msg = EmailMessage()
#     msg["Subject"] = "Obrigado pelo seu feedback! 💬"
#     msg["From"] = "contato@beautybarreto.com.br"
#     msg["To"] = destinatario

#     corpo = f"""
#     <html>
#     <body>
#         <p>Olá {nome_cliente},</p>
#         <p>Obrigado por avaliar seu atendimento no <strong>Beauty Barreto</strong>!</p>
#         <p><strong>⭐ Avaliação:</strong> {rating} estrelas<br>
#         <strong>📝 Comentário:</strong> “{comment}”</p>
#         <p>Ficamos felizes com sua opinião. Esperamos vê-lo novamente em breve!</p>
#         <p>Com carinho,<br>Equipe Beauty Barreto</p>
#     </body>
#     </html>
#     """

#     msg.set_content("Obrigado pelo seu feedback!")
#     msg.add_alternative(corpo, subtype="html")

#     with smtplib.SMTP_SSL("smtp.seudominio.com", 465) as smtp:
#         smtp.login("seu-usuario", "sua-senha")
#         smtp.send_message(msg)

# === CONSUMER ===
def on_message(channel, method, properties, body):
    try:
        data = json.loads(body.decode())
        console.rule("[bold green] Novo feedback recebido")
        console.print(JSON.from_data(data))

        feedback_id = salvar_feedback(data)
        if feedback_id:
            console.print(f"[bold blue] Feedback salvo com ID {feedback_id}.")
        else:
            console.print("[red] Falha ao salvar feedback.")

    except json.JSONDecodeError:
        console.print(f"[red] Erro ao decodificar JSON:[/red] {body}")
    finally:
        channel.basic_ack(delivery_tag=method.delivery_tag)

def main():
    params = pika.URLParameters(RABBITMQ_URL)
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE_NAME, durable=True)

    console.print(f" Aguardando feedbacks da fila [bold cyan]{QUEUE_NAME}[/bold cyan]...\n")
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