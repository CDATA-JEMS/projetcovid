provider "aws" {
    region = var.region_id
}

resource "aws_instance" "covidInfraEC2" { 
    ami = var.ami_id
    instance_type = var.type_EC2
    security_groups = [aws_security_group.covid_sg.name]
    key_name = aws_key_pair.olvCkeypair.key_name
    tags = {
        "Name" = "infraCovidProjet" 
    }
    
    root_block_device {
      volume_size = 20
    }

    user_data = <<-EOF
        #!/bin/bash
        apt update
        apt-get update
        apt install unzip -y
        apt install python3-pandas -y
        apt install docker.io -y

        mkdir /home/ubuntu/workdir
        cd /home/ubuntu/workdir

        # récupération des scripts de traitement des datas
        git clone https://github.com/CDATA-JEMS/projetcovid.git
        cd /home/ubuntu/workdir/projetcovid/ScriptFinal

        git clone https://github.com/CSSEGISandData/COVID-19.git
        for f in COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/*.csv; do fdate=$(basename $f .csv | awk -F- {'print $3"-"$1"-"$2'}); echo $fdate; touch -d "$(date -d $fdate)" $f; done
        
        mkdir format1 format2
        find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -not -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format1/
        find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format2/
        mkdir /home/ubuntu/results
        cp -r format* /home/ubuntu/results/

        cd /home/ubuntu/workdir
        touch test1
        rm -rf LiqEnt
        mkdir LiqEnt
        touch test2
        wget "https://www.insee.fr/fr/statistiques/serie/telecharger/001656092?ordre=antechronologique&transposition=donneescolonne&periodeDebut=1&anneeDebut=2018&periodeFin=11&anneeFin=2020" -O LiqEnt/LiqEnt.zip
        sleep 10
        cd LiqEnt
        touch test3
        unzip LiqEnt.zip
        rm LiqEnt.zip
        cp *.csv /home/ubuntu/results/
        cd ..

        cd /home/ubuntu/workdir/projetcovid/ScriptFinal
        python3 chomage.py
        cp chomageData.csv /home/ubuntu/results/
        cp rep* *.hive *.pig /home/ubuntu/results/



        #install docker et lancement cloudera quickstart
        
        docker pull cloudera/quickstart
        #sudo docker run --hostname=quickstart.cloudera -v /home/ubuntu/results:/root/shared --privileged=true -it cloudera/quickstart /usr/bin/docker-quickstart


        # #install docker compose
        # curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        # chmod +x /usr/local/bin/docker-compose
        
        # #copier projet git hadoop et lancer docker-compose
        # cd /home/ubuntu
        # git clone https://github.com/big-data-europe/docker-hadoop-spark-workbench
        
        # cd docker-hadoop-spark-workbench/
        # docker-compose -f docker-compose-hive.yml up -d

      EOF
}

//associer une keypair pour ssh. 
resource "aws_key_pair" "olvCkeypair" {
  key_name_prefix   = "olv-keypair-"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCw0AExreQ638y6hFoNVod42/wI9VCGRJX6n2RHcXVKxmkhv6+nWg6xTXo1tM7K3igvGyE8xwuuLyBtE/KH1EY8/mVDXiMpr/5OqER8ITVFFbvnV9zCb8XS7+T5XnQcZZx50Wk8ni0pVWPIcPv9O/LF6Y+m+VJJRAWPrF3lxywgW9O7NbaUk0MRwdF8EK7hi6kfT7GvfP5v6l8iKRsxkg18WRKpcgoowFUT2dgkjkhMKJocRMXOERxrZ3oOKC66UN1rK+P74MHlMqerddzqyIeO0Dz8rxFleCat7exSa87ShXKF+6m2zcVGfuUeEhmGONIlI2bnCbGd4qIPyh7DX63/B1C/SgjylbaM6e8DCEh3dRSJRmRI7WibuvPZuQ0oY9NR48aWG6hVVdt+CYQwERW3ToJ+PusGWy/QagSj9/3+mKwub7ZaVqcbgwu5j/JcXDH8we3o71A9/qktnFuD2hJP//Ypjqkbk7yzQDTCd2C2ZBrSeVm3yfHXPtbf/GnLuuc= fitec@FITEC"
}

//security group pour connexion 
resource "aws_security_group" "covid_sg" {
  name        = "covidprojet_sg"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description = "http from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "http over ssl from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "impala from anywhere"
    from_port   = 21050
    to_port     = 21050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "hive from anywhere"
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "webHDFS from anywhere"
    from_port   = 50070
    to_port     = 50070
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
