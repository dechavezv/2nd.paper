#!/bin/bash
for dir in Tree_*; do (cd $dir && /
cd modelA/Omega1 && /
cp align.phy aling.phy_$dir && /
mv aling.phy_$dir /u/home/d/dechavez/project-rwayne/PAML/Sequences);done

