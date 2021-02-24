#Par l'équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre du projet : Impact de la Covid sur les entreprises en Europe
#
#Script principal qui permet de lancer automatiquement les autres scripts 
#les services prérequis pour execution:
#Python3, Git, Wget, HDFS, PIG, HIVE, IMPALA, 
#
#Script pour rendre execcutables les autres scripts 
#
#premiere partie
#Il lance le script chargmtCovid.sh pour télécharger les données sur covid19 à partir de git
#Il lance le script repCovidPig.sh pour preparer le repertoire et envoyer les données sur HDFS 
#Il lance le covid.pig  pour nettoyer et normaliser les données.
#
#deuxieme partie 
#Il lance le script chargmtLiqEnt.sh pour télécharger les données sur liquidation entreprise à partir de insee
#Il lance le script repLiqEnt.sh pour preparer le repertoire et envoyer des données sur HDFS 
#
#Troisième partie
#Il lance le script pyhon 



#mettre executable tous les scripts
chmod +x *.sh


####################################
# lancement du script de chargement des données COVID-19 mondiales
./chargmtCovid.sh
sleep 3m

# lancement du script de preparation des repertoires covid19 sur HDFS
./repCovidPig.sh
sleep 3m

# lancement de  Pig shell de Covid, pour nettoyer, structurer et normaliser les données
pig covid.pig
sleep 3m

####################################
# lancement du script de chargement des données de liqudation des entreprises en France
./chargmtLiqEnt.sh
sleep 3m

# lancement du script de preparation des repertoires de liquidation des entreprises sur HDFS
./repLiqEnt.sh
sleep 3m

# lancement du shell Pig de LiqEnt, pour nettoyer, structurer et normaliser les données
pig LiqEnt.pig
sleep 3m


####################################
# lancement du script de chargement des données du chomage en Europe
pyhton chomage.py
sleep 1m

# lancement du script de preparation des repertoire de chomage sur HDFS
./repChomage.sh
sleep 3m

# lancement du shell Pig shell chomage, pour nettoyer, structurer et normaliser les données
pig chomage.pig
sleep 3m

#######################################
# lancement des requêtes dans hive pour création dataMarts 
hive scriptHive.hive

#######################################
# suppression des données
rm -rf format1
rm -rf format2
rm -rf liqEnt




