
# 1.single variant analysis for common variants
for i in $($chr)
do
/home1/Huashan1/wbs_data/software/plink2 \
--bfile ukb_wes_chr${i}_sample_qc_final_unrelated \
--keep caucasian_fam_id.txt \
--1 \
--glm hide-covar no-firth cols=chrom,pos,ax,a1freq,nobs,beta,se,tz,p \
--geno 0.05 \
--maf 0.01 \
--hwe 1e-6 \
--vif 1000 \
--pheno ${Pheno}.tsv \
--pheno-name ${Pheno} \
--covar-col-nums 7,8,10,11,12,13,14,15,16,17,18,19 \
--covar-variance-standardize age PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 \
--threads 40 \
--out ${Pheno}/chr${i}
done

# 2.clump
for i in $chr
do
plink \
--bfile ukb_wes_chr${i}_sample_qc_final_unrelated \
--keep caucasian_fam_id.txt \
--clump ${Pheno}_exon.tsv \
--clump-p1 1.17e-6 --clump-r2 0.01 --clump-kb 5000 \
--clump-snp-field ID --clump-field P \
--out ${Pheno}_chr${i} &
done