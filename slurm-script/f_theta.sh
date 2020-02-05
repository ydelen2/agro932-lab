#!/bin/bash -l
#SBATCH -D /common/jyanglab/jyang21/projects/agro932-lab
#SBATCH -o /common/jyanglab/jyang21/projects/agro932-lab/slurm-log/stdout-%j.txt
#SBATCH -e /common/jyanglab/jyang21/projects/agro932-lab/slurm-log/stderr-%j.txt
#SBATCH -J theta
#SBATCH -t 1:00:00
#SBATCH --mail-user=yangjl0930@gmail.com
#SBATCH --mail-type=END #email if ends
#SBATCH --mail-type=FAIL #email if fails
set -e
set -u

cd largedata/lab4/
# alignment
for i in {1..10}; do bwa mem Zea_mays.B73_RefGen_v4.dna.chromosome.Mt.fa l$i.read1.fq l$i.read2.fq | samtools view -bSh - > l$i.bam; done
# sort
for i in *.bam; do samtools sort $i -o sorted_$i; done
# index them
for i in sorted*.bam; do samtools index $i; done

