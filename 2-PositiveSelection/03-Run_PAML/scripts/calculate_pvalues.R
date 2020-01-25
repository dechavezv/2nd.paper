#set working directory
setwd(getwd())

args = commandArgs(trailingOnly=TRUE)
## args[1]

#read table
#statistic_genes = read.table('/u/scratch/d/dechavez/PAML/PAML/PAML_Likelihood/LRT_Edited_LRT_I_Masked_BBJ_SSJ_Jul25_2019.txt',header=F)

statistic_genes = read.table(args[1],header=F)
#now we will loop trough every statistic in the table to calculte its p-values
for (i in 1:length(statistic_genes[,2])){
x=statistic_genes[i,2] #take only the statistic
df=1 # degrees of freedom
p_value= 1-(pchisq(x, df))
statistic_genes[i,3] <-p_value 
if (p_value > 0.05){
statistic_genes[i,4] <- "NS" # No statistical significan
}
else{
statistic_genes[i,4] <-"*"  # Statistical significant 
} 
}


#rename_aditional_colums
names(statistic_genes)[3] <- "P-value"
names(statistic_genes)[4] <- "Static_Signif"


write.table(statistic_genes, file = args[2], sep = "\t", col.names = T)

