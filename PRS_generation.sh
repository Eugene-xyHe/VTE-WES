# 1. Genome-wide PRS
for i in $($chr)
do
python PRScs/PRScs.py \
    --ref_dir=ld_ref/ldblk_ukbb_eur \
    --bim_prefix=finngen_converted \
    --sst_file=finngen_converted.sumstats \
    --n_gwas=874155 \
    --chrom=${i}\
    --seed=31337 \
    --out_dir=prscs_out/chr${i}
	
plink2 \
    --bfile UKB_gene_v3_imp_qc_chr${i} \
  	--maf 0.01 --hwe 1e-6 --geno 0.05 \
  	--keep caucasian_id.txt \
  	--threads 40 \
    --score prscs_out/chr${i}_pst_eff_a1_b0.5_phiauto_chr${i}.txt 2 4 6 list-variants cols=+scoresums \
    --chr ${i} \
    --out vte.chr${i} &
done


# 2. PRS for common lead snp 
for i in $chr
do
plink2 \
--bfile ukb_wes_chr${i}_sample_qc_final_unrelated \
--score vte_lead_snp.tsv 1 2 3 list-variants cols=+scoresums \
--chr ${i} \
--out leadsnp_prs_v2.chr${i} &
done


