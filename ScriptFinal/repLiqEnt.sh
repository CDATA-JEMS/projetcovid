#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#Script est lancé autmatiquement par run.sh
#Scripte doit être lance après le script chargmtLiqEnt.sh
#Script pour preparation de repertoire de Pig pour les données sur liquidation des entreprise en france
#Envoie des données au HDFS, 
#suppression des anciens données s'il existe
#Cloudera doit être lancer avant d'execution de cette script

hadoop fs -mkdir -p /user/cloudera/datalake/prepared_data/LiqEnt

hadoop fs -rm /user/cloudera/datalake/prepared_data/LiqEnt/*

hadoop fs -put valeurs_mensuelles.csv /user/cloudera/datalake/prepared_data/LiqEntRéunion
