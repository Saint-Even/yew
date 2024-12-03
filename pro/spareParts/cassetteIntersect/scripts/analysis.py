import os, sys, fileinput
import difflib as dl

print("Begin: analysis.py")

rn= snakemake.wildcards.runName

ip0= snakemake.input[0]
ip1= snakemake.input[1]
ip2= snakemake.input[2]
ip3= snakemake.input[3]

op0= snakemake.output[0]
op1= snakemake.output[1]

#Produce 4 vcf summaries and combine to report
inputFiles = [ip0,ip1,ip2,ip3]

report= "REPORT on vcf files and intersection"
report+= f"\n0000\tTrain unique\n0001\tValidate unique\n0002\tTrain Intersect\n0003\tValidate Intersect\n"

for vcf in inputFiles:
    pipe=os.popen(f"bcftools stats --verbose {vcf}")

    report += f"\n\n\tAnalysis of: {vcf}\n"
    report += pipe.read()

with open(op0, "w") as writer:
    writer.write(report)

#Produce report on difference between vcf intersects

#read vcf files to summary strings
pipe= os.popen(f"bcftools stats --verbose {ip2}")
trainSummary= pipe.read()

pipe= os.popen(f"bcftools stats --verbose {ip3}")
validSummary= pipe.read()

#get context difference of strings
diffRep=""
for diff in dl.unified_diff(trainSummary, validSummary, n=32, lineterm='\n\n'):
    diffRep+= diff

#write context difference to file
with open (op1, "w") as writer:
    writer.write("Report on difference of vcf summary files\n")
    writer.write(diffRep)

