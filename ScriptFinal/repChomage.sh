#Par l'equipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre du projet : Impact de la Covid sur les entreprises en Europe
#Script lancé automatiquement par run.sh
#Script à lancer après le script chomage.pig
#Script de preparation de repertoire de Pig pour les données sur chomage en europe
#Envoi des données au HDFS, 
#suppression des anciennes données s'il elles existent
#Cloudera doit être lance avant d'execution de ce script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/chomage

hadoop fs -rm /user/cloudera/datalake/prepared_data/chomage/*

hadoop fs -put chomageData.csv /user/cloudera/datalake/prepared_data/chomage
