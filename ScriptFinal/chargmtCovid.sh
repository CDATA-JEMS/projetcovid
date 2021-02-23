#Preparer par équipe : NIKNAM Pedram,BEN AMMAR Amira, CHICOUARD Olivier, SUN Andelai. 
#Dans le cadre de projet:Impact de la Covid sur les entreprises en Europe
#Script est lancé autmatiquement par run.sh
#Scripte doit être lance avant le script repCovidpig.sh
# script prepare repertoir puis telecharge et separ les données covid19 dans les diff repertoir

#supression d'ancien données dans le cas d'existance
rm -rf COVID-19

git clone https://github.com/CSSEGISandData/COVID-19.git

# suppression des coma entre les doubles cote
sed -i ':a;s/^\(\([^"]*,\?\|"[^",]*",\?\)*"[^",]*\),/\1 /;ta' COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/*.csv

# Replace original file dates to match the dates included in the file names
for f in COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/*.csv; do
    fdate=$(basename $f .csv | awk -F- {'print $3"-"$1"-"$2'})
    echo $fdate
    touch -d "$(date -d $fdate)" $f
done

# creation de repertoir et copie des fichier dans les diff repertoir par rapport a leur type de date
mkdir format1
mkdir format2

find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -not -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format1/

find COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/ -maxdepth 1 -newermt "2020-03-21" -exec basename \{} .po \; | grep csv | sort | xargs -I % mv COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/% format2/

