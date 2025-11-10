DB_HOST="localhost"
DB_PORT="3306"
DB_USER="infra"
DB_PASSWORD="infra"
DB_NAME="grupo4"
BACKUP_DIR="/mysql_backups"

mkdir -p "$BACKUP_DIR"

DATE=$(date -I)

FILENAME="${DB_NAME}_${DATE}.sql"
FILEPATH="${BACKUP_DIR}/${FILENAME}"

echo "Gerando backup completo do banco '${DB_NAME}'..."
mysqldump --host="$DB_HOST" --port="$DB_PORT" \
          --user="$DB_USER" --password="$DB_PASSWORD" \
          --databases "$DB_NAME" > "$FILEPATH"

if [[ -s "$FILEPATH" ]]; then
  echo "[SUCESSO] Backup gerado em: $FILEPATH"
else
  echo "[ERRO] Arquivo de backup está vazio!" >&2
  exit 1
fi
