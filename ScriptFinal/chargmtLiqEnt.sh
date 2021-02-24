#Par l'equipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre du projet : Impact de la Covid19 sur les entreprises en Europe
#Script lancé automatiquement par run.sh
#Script lancer avant le script repLiqEnt.sh
#Ce script prepare repertoires puis telecharge les données sur les liquidations des entreprises en France de 2018 jusq'au fin 2020

rm -rf LiqEnt
mkdir LiqEnt
wget "https://www.insee.fr/fr/statistiques/serie/telecharger/001656092?ordre=antechronologique&transposition=donneescolonne&periodeDebut=1&anneeDebut=2018&periodeFin=11&anneeFin=2020" -O LiqEnt/LiqEnt.zip
sleep 10
cd LiqEnt
unzip LiqEnt.zip
rm LiqEnt.zip
cd ..
