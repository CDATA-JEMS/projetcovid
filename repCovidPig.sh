#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#Script est lancé autmatiquement par run.sh
#Scripte doit être lance après le script chargmtCovid.sh
#Script pour preparation de repertoire de Pig pour les données de Covide19,
#Envoie des données de covide19 au HDFS, 
#suppression des anciens données s'il existe
#Cloudera doit être lancer avant d'execution de cette script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/covid/format1

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/covid/format2



hadoop fs -rm /user/cloudera/datalake/prepared_data/covid/format1/*

hadoop fs -rm /user/cloudera/datalake/prepared_data/covid/format2/*

hadoop fs -put format1/* /user/cloudera/datalake/prepared_data/covid/format1

hadoop fs -put format2/* /user/cloudera/datalake/prepared_data/covid/format2
