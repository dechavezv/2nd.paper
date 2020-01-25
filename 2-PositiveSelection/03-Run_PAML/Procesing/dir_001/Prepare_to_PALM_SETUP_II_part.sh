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
