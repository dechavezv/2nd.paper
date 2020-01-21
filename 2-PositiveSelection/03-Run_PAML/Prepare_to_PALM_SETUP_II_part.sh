#! /bin/bash

#$ -l highp,h_rt=20:00:00,h_data=5G
#$ -pe shared 1
#$ -N four_HD_Indel_PAML_II
#$ -cwd
#$ -m bea
#$ -o ./four_HD_Indels_PAML_II.out
#$ -e ./four_HD_Indels_PAML_II.err
#$ -M dechavezv

. /u/local/Modules/default/init/modules.sh
module load python/2.7.3
module load perl/5.10.1
export PERL5LIB=$HOME/VESPA-1.0:$PERL5LIB


echo '############'
echo Aminoacid_to_nucleotide
echo '############'
for dir in Dir_*;do / 
(cd $dir && /
mv ENSCAFG* Transcript_database.txt && /
mkdir metAl_compare_Prank && /
cp *best.fas metAl_compare_Prank && sed -i -r 's/(>\w+)\|\w+\|\w+\|./\1/g' Transcript_database.txt && / 
python /u/home/d/dechavez/VESPA-1.0/vespa.py map_alignments -input=metAl_compare_Prank/ -database=Transcript_database.txt
);done

echo '############'
echo Get_alingment_in_phylip_format
echo '############'

for dir in Dir_*;do (cd $dir && cp fasta2phylip.pl Map_Gaps_metAl_compare_Prank && /
cd Map_Gaps_metAl_compare_Prank && /
for file in *.fas; do perl fasta2phylip.pl $file > $file.phy;done);done
pwd

echo '############'
echo Set_envitoment_for_Paml_analysis
echo '############'

for dir in Dir_*;do (cp -r tree/ $dir && /
cd $dir && /
cp tree.txt Map_Gaps_metAl_compare_Prank  && pwd && /
cp GenerateCodemlWorkspace.pl Map_Gaps_metAl_compare_Prank && /
cp -r CodemlWrapper/ Map_Gaps_metAl_compare_Prank/ && /
cp -r tree Map_Gaps_metAl_compare_Prank/ 
cd Map_Gaps_metAl_compare_Prank && /
cp tree.txt tree/modelA/Omega1/tree && /
cp *.phy tree/modelA/Omega1/align.phy && /
cp tree.txt tree/modelAnull/Omega1/tree && /
cp *.phy tree/modelAnull/Omega1/align.phy);done

echo '############'
echo PAML annalysis
echo '############'

for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/tree/modelA/Omega1 && /
codeml && /
cd .. && cd .. && /
cd modelAnull/Omega1 && codeml);done
 
echo '############'
echo Move_output_folder
echo '############'
for dir in Dir_*;do (cd $dir && cd Map_Gaps_metAl_compare_Prank/ && /
mv tree Tree_$dir && /
cp -r Tree_$dir /u/home/d/dechavez/project-rwayne/PAML/PAML_out);done
