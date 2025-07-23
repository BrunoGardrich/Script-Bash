#!/bin/bash

log_file="$HOME/manutencao.log"


log(){
  echo "$(date '+%d/%m/%Y %H:%M:%S') - $1" >> "$log_file"
}

uso_disco(){
  df -h
  echo " Analisando uso do Disco..."
  log "Verificando uso do disco"
}

clean_disco(){
  sudo apt clean
  sudo rm -rf /tmp/*
  log "Cache Limpo"
  echo "Cache limpo com sucesso."
}

monitorar_processos(){
  ps aux --sort=-%mem | head -n 10
  log "Monitorando Processos"
}

informacao_sistema(){
  echo "uptime: $(uptime -p)"
  echo "Usuario: $(whoami)"
  echo "IP: $(hostname -I)"
  echo "Kernel: $(uname -r)"
  log "Info do sistema exibidas"
}


backup(){
  read -p "Diretório para backup: " dir
  if [[ ! -d "$dir" ]]; then
    echo"Diretório Invalido"
    return
  fi

  destino="$HOME/backup_$(basename $dir)_$(date +%Y/%m/%d).tar.gz"
  tar -czf "$destino" "$dir"
  echo "Backup feito: $destino"
  log "Backup do diretorio $dir" 
}

menu() {
    while true; do
        echo ""
        echo "=== MENU DE MANUTENÇÃO ==="
        echo "1 - Limpar cache"
        echo "2 - Ver uso de disco"
        echo "3 - Monitorar processos"
        echo "4 - Info do sistema"
        echo "5 - Backup de diretório"
        echo "6 - Sair"
        read -p "Escolha uma opção: " opcao

        case $opcao in
            1) clean_disco ;;
            2) uso_disco ;;
            3) monitorar_processos ;;
            4) informacao_sistema ;;
            5) backup ;;
            6) echo "Saindo..."; log "Script finalizado"; break ;;
            *) echo "Opção inválida." ;;
        esac
    done
}

menu
