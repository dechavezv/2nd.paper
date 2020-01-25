#! /bin/bash

#$ -l highp,h_rt=20:00:00,h_data=5G
#$ -pe shared 1
#$ -N IIpartPAML
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML_II.out
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/PAML_II.err
#$ -M dechavezv

. /u/local/Modules/default/init/modules.sh
module load python/2.7.3
module load perl/5.10.1
export PERL5LIB=$HOME/VESPA-1.0:$PERL5LIB

export Direc=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML
export data=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML
export Vespa=/u/home/d/dechavez/VESPA-1.0/vespa.py

echo '############'
echo Aminoacid_to_nucleotide
echo '############'

for dir in Dir_*;do / 
(cd $dir && /
mv ENSCAFG* Transcript_database.txt && /
mkdir metAl_compare_Prank && /
cp *best.fas metAl_compare_Prank && sed -i -r 's/(>\w+)\|\w+\|\w+\|./\1/g' Transcript_database.txt && / 
python ${Vespa} map_alignments -input=metAl_compare_Prank/ -database=Transcript_database.txt
);done

echo '############'
echo Get_alingment_in_phylip_format
echo '############'

for dir in Dir_*;do (cd $dir && cp fasta2phylip.pl Map_Gaps_metAl_compare_Prank && /
cd Map_Gaps_metAl_compare_Prank && /
for file in *.fas; do perl fasta2phylip.pl $file > $file.phy;done);done


echo '############'
echo Set_envitoment_for_Paml_analysis
echo '############'

for dir in Dir_*;do (cp -r tree/ $dir && /
cd $dir && /
cp tree.txt Map_Gaps_metAl_compare_Prank  && pwd && /
cp GenerateCodemlWorkspace.pl Map_Gaps_metAl_compare_Prank && /
cp -r CodemlWrapper/ Map_Gaps_metAl_compare_Prank/ && /
cp -r tree Map_Gaps_metAl_compare_Prank/ 
cp codeml Map_Gaps_metAl_compare_Prank && /
cd Map_Gaps_metAl_compare_Prank && /
cp tree.txt tree/modelA/Omega1/tree && /
cp codeml tree/modelA/Omega1/
cp codeml tree/modelAnull/Omega1/
cp *.phy tree/modelA/Omega1/align.phy && /
cp tree.txt tree/modelAnull/Omega1/tree && /
cp *.phy tree/modelAnull/Omega1/align.phy);done


echo '############'
echo Set_forward_branch
echo '############'

for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/tree/modelA/Omega1 && /
perl -pe 's/Sven/Sven#1/g' tree > edited.tree && rm tree && mv edited.tree tree && /
cp tree ../../modelAnull/Omega1);done

echo '############'
echo PAML annalysis
echo '############'

for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/tree/modelA/Omega1 && /
./codeml && /
cd .. && cd .. && /
cd modelAnull/Omega1 && ./codeml);done
 
echo '############'
echo Move_output_folder
echo '############'
for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/ && /
mv tree Tree_$dir && /
cp -r Tree_$dir ${data}/PAML_out_before_SWAMP);done

echo '############'
echo Move_sequences
echo '############'
for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/Tree_$dir/modelA/Omega1 && /
cp align.phy aling.phy_$dir && /
mv aling.phy_$dir ${data}/sequences_before_SWAMP);done

echo '############'
echo Get Likelihoods
echo '############'

cd ${data}/PAML_out_before_SWAMP

for dir in Tree_*; do (cd $dir && /
cd modelA/Omega1 && /
grep 'lnL' out > out_modelA && /
mv out_modelA .. && /
cd .. && /
mv out_modelA .. && /
cd .. && /
cd modelAnull/Omega1 && /
grep 'lnL' out > out_modelAnull && /
mv out_modelAnull .. && /
cd .. && /
mv out_modelAnull .. && /
cd .. && /
sed -i -r 's/^\S+\s+(\w+)\s+\S+\s+(\w+)\S+\s+(\S+)\s+\S+/\1\t\2\t\3/g' out_modelA && /
sed -i -r 's/^\S+\s+(\w+)\s+\S+\s+(\w+)\S+\s+(\S+)\s+\S+/\1\t\2\t\3/g' out_modelAnull && /
printf '%s\n' "${PWD##*/}" > name_dircetory && /
sed -i -r 's/Tree_Dir_(\w+).fasta/\1/g' name_dircetory && /
paste out_modelA out_modelAnull name_dircetory| column -s $'\t' -t > LTR_PAML.out && /
sed -i -r 's/^(\w+)\s+(\w+)\s+(\S+)\s+(\w+)\s+(\w+)\s+(\S+)\s+(\w+)/\7\t\3\t\6\t\1\t\2\t\4\t\5/g' LTR_PAML.out && /
mv LTR_PAML.out ${PWD##*/}_LTR_PAML.out && /
cp *_LTR_PAML.out ${Direc}/PAML_LRT && /
rm *);done

cat ${Direc}/PAML_LRT/*_LTR_PAML.out > ${data}/PAML_LRT/Canids.Likelihood.$(date | perl -pe 's/\w+\s+(\w+)\s+(\d+)\s+\d+\:\d+\:\d+\s+PST\s+(\d+)/\1.\2.\3/g').txt

echo '############'
echo Get p-values
echo '############'

cd ${data}/PAML_LRT

export input=Canids.Likelihood.$(date | perl -pe 's/\w+\s+(\w+)\s+(\d+)\s+\d+\:\d+\:\d+\s+PST\s+(\d+)/\1.\2.\3/g').txt
export scripts=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/scripts
export R=/u/local/apps/R/3.5.0/gcc-6.3.0_MKL-2017/bin
export anaconda=/u/home/d/dechavez/anaconda3/bin

grep -E -v '^[0-9]|^\w+$' ${input} > Edited_${input} #delete empty line from file
${anaconda}/python ${scripts}/calculate_LTR.py Edited_${input} LRT_Edited_${input} #calculate LRT, for mor einformation on how to calculate LRT and p_valus go to https://evosite3d.blogspot.com/2011/09/identi$
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

 
#rm Edited_${input}  #delete intermidiate files
#rm Edited_Pvalue_${input} #delete intermidiate files
#rm LRT_Edited_${input} #delete intermidiate files
#rm Filtered_${input} #delete intermidiate files

echo '############'
echo Get BEB sires
echo '############'
# these commands will work with the following path
## <something>/PAML_out/Tree_Dir_ENSCAFG00000000001.fasta/modelA/Omega1/
## If you dont have the path above change the regualr expresion " after sed "1i$(echo ${PWD##*line/}


mkdir ${Direc}/BEB_Sites

export BEB_Sites=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/BEB_Sites
export PAML_dir=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/PAML_out_before_SWAMP
export script=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/scripts
export Pvalue=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/PAML_LRT

cd ${PAML_dir}

echo " ************************** Extracting BEB Sites *********************************************** "

for dir in Tree*; do (cd $dir/modelA/Omega1 && python ~/project-rwayne/scripts/Python/Get_BEB_sites.py out_masked \
|  grep -P '\.' | grep -v 'The grid' | grep -v 'Bayes' | sed "1i$(echo ${PWD##*line/} | \
perl -pe 's/.*PAML_out\/Tree_Dir_(\w+).fasta.*/\1/g')" | perl -pe 's/^\s+//g' | \
perl -pe 's/(ENSCAFG\d+)\n/\1\|/g' | perl -pe 's/\n/,/g' | perl -pe 's/\|/\t/g' \
| perl -pe 's/$/\n/g' | perl -pe 's/,\n/\n/g');done > ${BEB_Sites}/BEB_$(date | perl -pe 's/\w+\s+(\w+)\s+(\d+)\s+\d+\:\d+\:\d+\s+PST\s+(\d+)/\1.\2.\3/g').txt

echo " ************************** Extracting BEB Sites *********************************************** "

# For this part of the script to work you must transfer the table with Pvalues to this directory
# Here the table with Pvalues  is `Pvalue_LRT_I_Masked_BD_MW_Feb17_2019.txt`

cd ${BEB_Sites}

python ${script}/Append_BEB_site_to_table.py ${Pvalue}/P_values_${input} BEB_$(date | perl -pe 's/\w+\s+(\w+)\s+(\d+)\s+\d+\:\d+\:\d+\s+PST\s+(\d+)/\1.\2.\3/g').txt BEB_
mv BEB_P_values* ${data}
