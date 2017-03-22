#!/bin/bash

cd docs

#for each pdf file
for f in *.pdf
do
	#export pdf as text and save results to csv
    pdftotext $f - | wc -w | sed s/"^"/"$f,"/ >> wordcount.csv
done

mv wordcount.csv ../
