#Par l'quipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre du projet : Impact de la Covid19 sur les entreprises en Europe
#Script lancé automatiquement par run.sh
#Script à lancer après le script chargmtCovid.sh
#Script pour preparation des repertoire de Pig sur les données de Covid19,
#Envoi des données de covid19 sur HDFS, 
#suppression des anciennes données si elles existent
#Cloudera doit être lancé avant execution de ce script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/covid/format1

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/covid/format2



hadoop fs -rm /user/cloudera/datalake/prepared_data/covid/format1/*

hadoop fs -rm /user/cloudera/datalake/prepared_data/covid/format2/*

hadoop fs -put format1/* /user/cloudera/datalake/prepared_data/covid/format1

hadoop fs -put format2/* /user/cloudera/datalake/prepared_data/covid/format2
