#Par l'equipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet : Impact de la Covid19 sur les entreprises en Europe
#Script lancé automatiquement par run.sh
#Script à lancer après le script chargmtLiqEnt.sh
#Script de preparation de repertoire de Pig pour les données sur liquidation des entreprise en france
#Envoi des données sur HDFS, 
#suppression des anciennes données si elles existent
#Cloudera doit être lance avant d'execution de ce script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/LiqEnt

hadoop fs -rm /user/cloudera/datalake/prepared_data/LiqEnt/*

hadoop fs -put valeurs_mensuelles.csv /user/cloudera/datalake/prepared_data/LiqEntRéunion
