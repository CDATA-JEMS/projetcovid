#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#Script est lancé autmatiquement par run.sh
#Scripte doit être lance après le script chomage.pig
#Script pour preparation de repertoire de Pig pour les données sur chomage en europe
#Envoie des données au HDFS, 
#suppression des anciens données s'il existe
#Cloudera doit être lancer avant d'execution de cette script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/chomage

hadoop fs -rm /user/cloudera/datalake/prepared_data/chomage/*

hadoop fs -put chomageData.csv /user/cloudera/datalake/prepared_data/chomage
