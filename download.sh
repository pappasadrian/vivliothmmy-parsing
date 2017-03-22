#!/bin/bash

wget -q http://vivliothmmy2.ee.auth.gr/en/search-thesis/

#find out how many pages of results are available
#look at the bottom page nav menu
grep "a title=\"Last\"" index.html | sed s/"^.*a title=\"Last\""// | sed s/"^.*data-page=\""// | sed s/"\" ><span class=.*"// > numpages

numpages=`cat numpages`
rm numpages
rm *.html

#for each result page
for currentpage in `seq 1 $numpages`;
do
    #get the current results page
    wget http://vivliothmmy2.ee.auth.gr/en/search-thesis/?listpage=$currentpage
    mv index.* page.html
    #parse results into csv
    grep -i -e '</\?TABLE\|</\?TD\|</\?TR\|</\?TH' page.html | sed 's/^[\ \t]*//g' | tr -d '\n' | sed 's/<\/TR[^>]*>/\n/Ig'  | sed 's/<\/\?\(TABLE\|TR\|SPAN\|THEAD\|FORM\|DIV\)[^>]*>//Ig' | sed 's/^<T[DH][^>]*>\|<\/\?T[DH][^>]*>$//Ig' | sed 's/<\/T[DH][^>]*><T[DH][^>]*>/\t/Ig' | tail -n +2 | sed 's/ \+/ /g' | sed 's/[ ]\/[ ]/\//g' | sed 's/ \t/\t/g' | sed s/"<a href=\""/""/g | sed s/"\.pdf.*"/"\.pdf"/g >> thesis-list.csv
    #csv separator is the tab, because all other typical characters are used in the content
done 

rm *.html

cp thesis-list.csv docs/out.csv
cd docs

#for each line in the csv file - for each individual thesis
echo out.csv | while read line
do
    url=`cut -d$'\t' -f6  $line`
    #download it and save it with its original name
    wget -q $url
done
rm *.csv

