#!/bin/bash

#$ -l highp,h_rt=10:00:00,h_data=20G
#$ -pe shared 1
#$ -N qualimpa_Coyote_BQR
#$ -cwd
#$ -m bea
#$ -o ./1P_4_qualimpa_BQR_Coyote.out
#$ -e ./1P_4_qualimpa_BQR_Coyote.err
#$ -M dechavezv

# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load java/1.7.0_45

export BAM_DIR=/u/scratch/d/dechavez/Coyote/2nd_call_cat_samt_ug_hc_fb_Coyote_raw.vcf.table_Reheader.bam 

/u/home/d/dechavez/qualimap_v0.7.1/qualimap bamqc -bam ${BAM_DIR} --java-mem-size=13G

