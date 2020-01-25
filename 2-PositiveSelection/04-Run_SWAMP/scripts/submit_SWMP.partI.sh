#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
#$ -l highp,h_rt=16:00:00,h_data=1G
#$ -N I_SWAMP
#$ -o /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/log/I_SWAMP
#$ -e /u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/03-Run_PAML/log/I_SWAMP
#$ -m abe
#$ -M dechavezv

SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP/scripts
DIREC=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/04-Run_SWAMP
export seq=/u/home/d/dechavez/project-rwayne/2nd.paper/data/PAML/sequences_before_SWAMP


QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub


cd ${DIREC}

echo '############'
echo Make_dir_for_PAML
echo '############'

cp ${seq}/* ./

for file in *.fasta; do (mkdir Dir_$file && mv $file Dir_$file && /
cp -r scripts/tree Dir_$file && /
cd Dir_$file && cp $file tree/modelA/Omega1 && /
cd tree/modelA/Omega1 && mv *.fasta align.phy);done

echo '############'
echo  Make_subfolders_to_parallilize
echo '############'
i=0; for f in *.fasta; do d=dir_$(printf %03d $((i/200+1))); mkdir -p $d; mv "$f" $d; let i++; done

sleep 1m

for file in dir*; do (echo $dir && $QSUB ${SCRIPTDIR}/Run.PAML.zero.rate.sh $dir);done > Paml.on.swamp.log
sleep 20m
