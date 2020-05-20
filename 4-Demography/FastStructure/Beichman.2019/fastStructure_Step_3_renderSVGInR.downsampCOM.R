##### Faststructure outputs SVG plots 
# download them and copy to : /Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE
calldate=20181119 # date genotypes were called
wd=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/analysisResults/FASTSTRUCTURE/",calldate,"/downsampCOM/",sep="")
outdir7=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE/",calldate,"-downsampCOM/snp7",sep="")
outdir9a=paste("/Users/annabelbeichman/Documents/UCLA/Otters/OtterExomeProject/results/plots/FASTSTRUCTURE/",calldate,"-downsampCOM/snp9a",sep="")
dir.create(outdir7)
dir.create(outdir9a)

# install.packages("rsvg")
# install.packages("svglite")
require(rsvg)
#require(svglite)
# convert to PDF
for (i in seq(1,10)){
  print(i)
  svg1File <- paste(wd,"/svg/snp7/downsampled.COM.rmSergioInds.snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.faststructure_plot.",i,".svg",sep="")
  rsvg_pdf(svg1File, paste(outdir7,"/downsampled.COM.rmSergioInds.snp_7_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.faststructure_plot.",i,".pdf",sep=""))
  svg2File <- paste(wd,"/svg/snp9a/downsampled.COM.rmSergioInds.snp_9a_forPCAetc_maxHetFilter_0.75_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.faststructure_plot.",i,".svg",sep="")
  rsvg_pdf(svg2File, paste(outdir9a,"/downsampled.COM.rmSergioInds.snp_9a_forPCAetc_maxHetFilter_0.75_rmRelatives_rmAdmixed_passingBespoke_maxNoCallFrac_0.2_passingBespoke_passingAllFilters_postMerge_raw_variants.faststructure_plot.",i,".pdf",sep=""))
}
