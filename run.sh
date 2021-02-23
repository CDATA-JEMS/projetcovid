#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#
#Script principal qui permet de lance automatiquement plusieur d'autre script 
#les services prérequis pour executions:
#Python3, Git, Wget, HDAS, PIG, HIVE, IMPALA, 
#
#Script rendre execcutables les autres scriptes 
#
#première partie
#Il lance le script chargmtCovid.sh pour télécharge les données sur covide19 à partir de git
#Il lance le script repCovidPig.sh pour preparer le repertoire et envoies des données en HDFS 
#Il lance le covid.pig  pour nettoyer et normaliser les données.
#
#deuxieme partie 
#Il lance le script chargmtLiqEnt.sh pour télécharge les données sur liquidation entreprise à partir de insee
#Il lance le script repLiqEnt.sh pour preparer le repertoire et envoies des données en HDFS 
#
#Troisième partie
#Il lance le script pyhon 







#mettre executable tous les scripts
chmod +x *.sh



####################################
# lancement de script pour chargement des données COVID-19 dans mondes
./chargmtCovid.sh
sleep 3m

# lancement de script pour preparation de repertoire de covide en HDFS
./repCovidPig.sh
sleep 3m

# lancement de  Pig shell de Covid, pour netoyager, structurer et normaliser les données
pig covid.pig
sleep 3m

####################################
# lancement de script pour chargement des données sur liqudation des entreprise en france
./chargmtLiqEnt.sh
sleep 3m

# lancement de script pour preparation de repertoire de Liquidation d'entreprise en HDFS
./repLiqEnt.sh
sleep 3m

# lancement de  Pig shell de LiqEnt, pour netoyager, structurer et normaliser les données
pig LiqEnt.pig
sleep 3m


####################################
# lancement de script pour chargement des données sur chomage en Europe
pyhton chomage.py
sleep 1m

# lancement de script pour preparation de repertoire de Liquidation d'entreprise en HDFS
./repChomage.sh
sleep 3m

# lancement de  Pig shell de LiqEnt, pour netoyager, structurer et normaliser les données
pig chomage.pig
sleep 3m

#######################################
# suppression des données
rm -rf format1
rm -rf format2
rm -rf liqEnt




