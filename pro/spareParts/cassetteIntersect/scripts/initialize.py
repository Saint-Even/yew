import os, sys, fileinput

print("Begin: initialize.py")

rn= snakemake.wildcards.runName
ip0= snakemake.input[0]

#print(f"TEST ip0:{ip0} ip1:{ip1} op:{op} rn:{rn}")

os.system(f"mkdir -p data/{rn}")
os.system(f"cp {ip0} data/{rn}")


