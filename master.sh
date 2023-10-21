#!/bin/bash

# Configurações
ADVERTISE_ADDR="10.10.10.100"
OUTPUT_FILE="/vagrant/worker.sh"

# Função para inicializar o Docker Swarm
init_docker_swarm() {
    echo "Iniciando o Docker Swarm..."
    if sudo docker swarm init --advertise-addr="$ADVERTISE_ADDR"; then
        echo "Docker Swarm iniciado com sucesso."
    else
        echo "Erro ao iniciar o Docker Swarm."
        exit 1
    fi
}

# Função para gerar o script de junção do worker
generate_worker_join_script() {
    echo "Gerando script de junção do worker..."
    if sudo docker swarm join-token worker | grep docker > "$OUTPUT_FILE"; then
        echo "Script de junção do worker gerado em $OUTPUT_FILE."
    else
        echo "Erro ao gerar o script de junção do worker."
        exit 1
    fi
}

# Função principal
main() {
    init_docker_swarm
    generate_worker_join_script
}

main
