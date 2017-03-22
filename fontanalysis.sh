#!/bin/bash

cd docs

#for each pdf
for f in *.pdf
do
	#extract font name data from each file, parse to csv file
    strings "$f" | grep FontName | cut -d '/' -f5 | cut -d '+' -f2 | cut -d ',' -f1 | sed s/" "//g | sort | uniq | tr '\n' ',' | sed s/"\#20"/' '/g | sed s/"^"/"\n$f,"/  >> fontsperdoc.csv
done

mv fontsperthesis.csv ../
cd ..

#count the occurence of each font in all the theses
#save result in a csv file
cat fontsperthesis.csv | cut -d ',' -f2-100| tr ',' '\n'| sort | uniq -c | sort -nr |tail -n +2 | sed 's/ \+/ /g' | sed s/" "/""/ | sed s/" "/"\,"/ > fontoccurence.csv
