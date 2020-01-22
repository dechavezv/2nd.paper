# this script will work with the following path
## <something>/PAML_out/Tree_Dir_ENSCAFG00000000001.fasta/modelA/Omega1/
## If you dont have the path above change the regualr expresion " after sed "1i$(echo ${PWD##*line/}

export BEB_Sites=/u/home/d/dechavez/project-rwayne/BEB_Sites 
export PAML_dir=/u/flashscratch/d/dechavez/PAML/PAML_Feb6/PAML_out
export script=/u/home/d/dechavez/project-rwayne/scripts

cd ${PAML_dir}

echo " ************************** Extracting BEB Sites *********************************************** "

for dir in Tree*; do (cd $dir/modelA/Omega1 && python ~/project-rwayne/scripts/Python/Get_BEB_sites.py out_masked \
|  grep -P '\.' | grep -v 'The grid' | grep -v 'Bayes' | sed "1i$(echo ${PWD##*line/} | \
perl -pe 's/.*PAML_out\/Tree_Dir_(\w+).fasta.*/\1/g')" | perl -pe 's/^\s+//g' | \
perl -pe 's/(ENSCAFG\d+)\n/\1\|/g' | perl -pe 's/\n/,/g' | perl -pe 's/\|/\t/g' \
| perl -pe 's/$/\n/g' | perl -pe 's/,\n/\n/g');done > ${BEB_Sites}/BEB_Sites_BD_MW_May8th_2019.txt

echo " ************************** Extracting BEB Sites *********************************************** "

# For this part of the script to work you must transfer the table with Pvalues to this directory
# Here the table with Pvalues  is `Pvalue_LRT_I_Masked_BD_MW_Feb17_2019.txt`
 
# cd ${BEB_Sites}

# python ${script}/Append_BEB_site_to_table.py Pvalue_LRT_I_Masked_BD_MW_Feb17_2019.txt BEB_Sites_BD_MW_May8th_2019.txt BEB_
