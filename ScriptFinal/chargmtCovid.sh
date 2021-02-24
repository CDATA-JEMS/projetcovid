#Par l'équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre du projet : Impact de la Covid sur les entreprises en Europe
#Script lancé autmatiquement par run.sh
#Ce script doit être lancé avant le script repCovidpig.sh
#Ce script prépare les fichiers du répertoire puis télécharge et sépare les données covid19 dans les différents repertoires

#supression d'anciennes données en cas d'existence
rm -rf COVID-19

git clone https://github.com/CSSEGISandData/COVID-19.git

# suppression des coma entre les doubles quote
sed -i ':a;s/^\(\([^"]*,\?\|"[^",]*",\?\)*"[^",]*\),/\1 /;ta' COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/*.csv

# Replace original file dates to match the dates included in the file names
for f in COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/*.csv; do
    fdate=$(basename $f .csv | awk -F- {'print $3"-"$1"-"$2'})
    echo $fdate
    touch -d "$(date -d $fdate)" $f
done

# creation de repertoires et copie des fichiers dans les diff repertoires par rapport a leur type de date
mkdir format1 
mkdir format2

find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -not -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format1/

find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format2/

