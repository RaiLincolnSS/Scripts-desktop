#!/bin/bash

#install ssm agent
#Cria diretorio no /tmp
#Condição para verificar se ja existe ssm instalado



# if systemctl status amazon-ssm-agent &> /dev/null

# then

#     echo "SSM Agent já está instalado."



# else

#     echo "SSM Agent não está instalado. Prosseguindo com a instalação."



#     mkdir /tmp/ssm

#     cd /tmp/ssm



#     wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb



#     dpkg -i amazon-ssm-agent.deb



#     systemctl enable amazon-ssm-agent



#     systemctl start amazon-ssm-agent



#     echo "SSM Agent instalado com sucesso."

# fi





#install zabbix agent

ZABBIX_SERVER="172.31.77.21"


VERSION_ZABBIX=7.4
#RELEASE=https://repo.zabbix.com/zabbix/$VERSION_ZABBIX/release/$SO/pool/main/z/zabbix-release/zabbix-release_latest_$VERSION_ZABBIX+$SO$ID_VERSION_all$EXTENSAO
#DPKJ=zabbix-release_latest_$VERSION_ZABBIX-1+$SO$ID_VERSION_all$EXTENSAO
    

if [ -f /etc/os-release ]; then

    source /etc/os-release

else

    echo "Não foi possível encontrar /etc/os-release."

    exit 1

fi

if [ "$ID" = "debian" ]; then

    SO="debian"
    EXTENSAO=".deb"

        if [ "$VERSION_ID" == "10" ]; then

            ID_VERSION="10"

                RELEASE=https://repo.zabbix.com/zabbix/$VERSION_ZABBIX/release/$SO/pool/main/z/zabbix-release/zabbix-release_latest_$VERSION_ZABBIX+$SO${ID_VERSION}_all$EXTENSAO

                DPKJ=zabbix-release_latest_$VERSION_ZABBIX-1+$SO${ID_VERSION}_all$EXTENSAO

                wget $RELEASE

                dpkg -i $DPKJ

                apt update

                apt install zabbix-agent2 -y

                systemctl restart zabbix-agent2

                systemctl enable zabbix-agent2

        fi

fi

if [ "$ID" = "ubuntu" ] || [ "$ID" = "pop" ]; then

    SO="ubuntu"
    EXTENSAO=".deb"


    if [ "$VERSION_ID" == "22.04" ]; then # Ubuntu 22.04 ou Pop OS 22.04

        ID_VERSION="22.04"

        RELEASE=https://repo.zabbix.com/zabbix/$VERSION_ZABBIX/release/$SO/pool/main/z/zabbix-release/zabbix-release_latest_$VERSION_ZABBIX+$SO${ID_VERSION}_all$EXTENSAO

        DPKJ=zabbix-release_latest_$VERSION_ZABBIX+$SO${ID_VERSION}_all$EXTENSAO

        wget $RELEASE

        dpkg -i $DPKJ
                

        apt update

        apt install zabbix-agent2 -y

        systemctl restart zabbix-agent2

        systemctl enable zabbix-agent2
    
    fi


fi

# edita o arquivo /etc/zabbix/zabbix_agent2.conf



AGENT_CONF="/etc/zabbix/zabbix_agent2.conf"

declare -A agent_config=(

  ["Server"]="$ZABBIX_SERVER"

  ["ServerActive"]="$ZABBIX_SERVER"

  ["Hostname"]="$1"

  ["AllowKey"]="system.run[*]"

)

for key in "${!agent_config[@]}"; do

  value="${agent_config[$key]}"

  if grep -q "^$key=" "$AGENT_CONF"; then

    sed -i "s|^$key=.*|$key=$value|" "$AGENT_CONF"

  else

    echo "$key=$value" >> "$AGENT_CONF"

  fi

done



echo "Configurações aplicadas. Reiniciando o zabbix-agent2..."

systemctl restart zabbix-agent2