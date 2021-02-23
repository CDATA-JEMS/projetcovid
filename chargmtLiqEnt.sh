#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#Script est lancé autmatiquement par run.sh
#Scripte doit être lance avant le script repLiqEnt.sh
# script prepare repertoir puis telecharge et des zipe les données qur les liquidation des entreprise en france de 2018 jusq'au fin 2020

rm -rf LiqEnt
mkdir LiqEnt
wget "https://www.insee.fr/fr/statistiques/serie/telecharger/001656092?ordre=antechronologique&transposition=donneescolonne&periodeDebut=1&anneeDebut=2018&periodeFin=11&anneeFin=2020" -O LiqEnt/LiqEnt.zip
sleep 10
cd LiqEnt; unzip LiqEnt.zip; rm LiqEnt.zip; cd ..
ls LiqEnt/
