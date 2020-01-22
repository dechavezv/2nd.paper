#!/bin/bash
#$ -l highp,h_rt=10:00:00,h_data=5G
#$ -pe shared 1
#$ -N Get_P_values_BD_MW_Feb18_2019_PAML_I
#$ -cwd
#$ -m bea
#$ -o ./Get_P_values_BD_MW_Feb18_2019_PAML_I.out
#$ -e ./Get_P_values_BD_MW_Feb18_2019_PAML_I.err
#$ -M dechavezv

echo Author Daniel E. Chavez 2017

#this script will edit the LRT files in order to be used within the calculate_pvalues.R script
#Be sure first to concatenate the files using cat
#Be sure to have the following scripts in the same path were your LRT_file(s) are/is located at

export input=LRT_I_BD_MW_Feb12_20019.txt
export scripts=/u/home/d/dechavez/project-rwayne/scripts
export R=/u/local/apps/R/3.5.0/gcc-6.3.0_MKL-2017/bin

echo '##############'
echo Editing_LRT_file
echo '##############'

grep -E -v '^[0-9]|^\w+$' ${input} > Edited_${input} #delete empty line from file
/u/home/d/dechavez/anaconda3/bin/python ${scripts}/Python/calculate_LTR.py Edited_${input} LRT_Edited_${input} #calculate LRT, for mor einformation on how to calculate LRT and p_valus go to https://evosite3d.blogspot.com/2011/09/identifying-positive-selection-in.html 
${R}/Rscript ${scripts}/R/calculate_pvalues.R LRT_Edited_${input} Pvalue_${input} #calculate p_calues with one degree of freedom
awk '{ print $2,$3,$4,$5}' Pvalue_${input} \
| perl -pe 's/"//g' | perl -pe 's/V2/Ensmebl_ID\tStatistic/;s/P-value/Pvalue/;s/Static_Signif/Significance/g' \
> Edited_Pvalue_${input}
rm Pvalue_${input}
mv Edited_Pvalue_${input} Pvalue_${input}
perl -pe 's/\n/\|/g' Pvalue_${input} | perl -pe 's/\s+/\t/g' | perl -pe 's/\|/\n/g' \
> Edited_Pvalue_${input}
rm Pvalue_${input}
mv Edited_Pvalue_${input} Pvalue_${input}
#grep -wF -f List_genesFiltered_CovariatesFixed_dictionary.txt Edited_Pvalue_${input} > Filtered_${input} #this will keep elements from file 1 within file2
#awk '!($1="")' Filtered_${input} > P_values_${input}

rm Edited_${input}  #delete intermidiate files
#rm Pvalue_${input} #delete intermidiate files
rm Edited_Pvalue_${input} #delete intermidiate files
rm LRT_Edited_${input} #delete intermidiate files
rm Filtered_${input} #delete intermidiate files
