#!/bin/bash
set -e
set -x

# Function to execute SQL commands
execute_sql() {
    local sql_command="$1"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
        $sql_command
EOSQL
}

# Create hiveuser role with password
execute_sql "CREATE ROLE hiveuser WITH LOGIN PASSWORD '$POSTGRES_PASSWORD';"

# Grant privileges to the hiveuser role on the metastore database
execute_sql "GRANT ALL PRIVILEGES ON DATABASE metastore TO $POSTGRES_USER;"

echo "Setup script completed."