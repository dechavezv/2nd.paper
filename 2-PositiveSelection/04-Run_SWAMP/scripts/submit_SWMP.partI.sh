#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
#$ -l h_rt=24:00:00,h_data=1G
#$ -N I_SWAMP
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/I_SWAMP
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/I_SWAMP
#$ -m abe
#$ -M dechavezv

# highp

export SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/scripts
export DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
export seq=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/sequences_before_SWAMP

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd ${DIREC}
mkdir processing
cd processing/

echo '############'
echo Make_dir_for_PAML
echo '############'

cp ${seq}/* ./

echo '############'
echo  Make directories and move files
echo '############'

for file in *.fasta; do (mkdir Dir_$file && mv $file Dir_$file && /
cp -r ${SCRIPTDIR}/tree Dir_$file && /
cd Dir_$file && cp $file tree/modelA/Omega1 && /
cp ${SCRIPTDIR}/codeml tree/modelA/Omega1 && /
cp ${SCRIPTDIR}/codeml tree/modelAnull/Omega1 && /
cp ${SCRIPTDIR}/codeml_modelA_rate_zero.ctl tree/modelA/Omega1 && /
cp ${SCRIPTDIR}/codeml_modelA_masked.ctl tree/modelA/Omega1 && /
cp ${SCRIPTDIR}/codeml_modelAnull_masked.ctl tree/modelAnull/Omega1 && /
cd tree/modelA/Omega1 && mv *.fasta align.phy);done

cd ${DIREC}/processing

echo '############'
echo  Make subfolders to parallelize
echo '############'
i=0; for f in Dir_*; do d=dir_$(printf %03d $((i/200+1))); mkdir -p $d; mv "$f" $d; let i++; done


for dir in dir*; do (echo $dir && cd $dir && $QSUB ${SCRIPTDIR}/Run.PAML.zero.rate.sh);done
