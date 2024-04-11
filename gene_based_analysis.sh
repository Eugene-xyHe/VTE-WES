# gene-based collapsing analysis for rare variants
for i in ${chr};do
Rscript step1_fitNULLGLMM.R \
 --sparseGRMFile=UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
 --sparseGRMSampleIDFile=UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
 --plinkFile=ukb_wes_chr${i}_sample_qc_final_unrelated \
 --useSparseGRMtoFitNULL=FALSE \
 --useSparseGRMforVarRatio=TRUE \
 --phenoFile=${Pheno}.csv \
 --phenoCol=${pheno_colname} \
 --covarColList=sex,age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
 --sampleIDColinphenoFile=eid \
 --isCovariateOffset=FALSE \
 --traitType=binary \
 --nThreads=30 \
 --isCateVarianceRatio=${iscatevarianceratio} \
 --outputPrefix=${Pheno}/${Pheno}_s1_chr${i} \
 --IsOverwriteVarianceRatioFile=TRUE
 
 Rscript step2_SPAtests.R \
 --bedFile=ukb_wes_chr${i}_sample_qc_final_unrelated.bed \
 --bimFile=ukb_wes_chr${i}_sample_qc_final_unrelated.bim \
 --famFile=ukb_wes_chr${i}_sample_qc_final_unrelated.fam \
 --AlleleOrder=alt-first \
 --minMAF=0 \
 --minMAC=0.5 \
 --GMMATmodelFile=${Pheno}/${Pheno}_s1_chr${i}.rda \
 --varianceRatioFile=${Pheno}/${Pheno}_s1_chr${i}.varianceRatio.txt \
 --sparseGRMFile=UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
 --sparseGRMSampleIDFile=UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
 --groupFile=SnpEff_gene_group_chr${i}.txt \
 --annotation_in_groupTest="lof,missense:lof,missense" \
 --maxMAF_in_groupTest=0.00001,0.0001,0.001,0.01 \
 --is_output_markerList_in_groupTest=TRUE \
 --LOCO=FALSE \
 --SAIGEOutputFile=${Pheno}/${Pheno}_s2_chr${i}.txt \
 --is_fastTest=TRUE
done