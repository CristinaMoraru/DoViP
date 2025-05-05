# Detailed outputs

All the outputs from an individual sample are saved within its corresponding folder. Outputs are grouped into subfolders corresponding to the step that generated them, with their names beeing suggestive for the respective step. Such a project folder is exemplified below.  

```plaintext
single_workflow_project_name/ 
    ├── 00_ALL_min_length_#
    |        ├── outMFasta_small.fna   
    ├── 01a_ALL_genomad
    |        ├── 01a_ALL_01_genomad_out
    |        ├── 01a_ALL_02_postgenomad_integrated_df.tsv
    |        ├── 01a_ALL_02_postgenomad_nonintegrated_df.tsv
    ├── 01b_ALL_DVF
    |        ├── 01b_ALL_01_DVF_out
    |        ├── 01b_ALL_postdfvf_nonintegrated_df.tsv
    ├── 01c_ALL_virSorter2
    |        ├── 01c_ALL_01_virSorter2_out
    |        ├── 01c_ALL_02_postVS2_integrated_df.tsv
    |        ├── 01c_ALL_02_postVS2_nonintegrated_df.tsv
    ├── 01d_ALL_vibrant
    |        ├── 01d_ALL_01_vibrant_out
    |        ├── 01d_ALL_02_postvibrant_integrated_df.tsv
    |        ├── 01d_ALL_02_postvibrant_nonintegrated_df.tsv
    ├── 01e_ALL_viralVerify
    |        ├── 01e_ALL_01_viralVerify_out
    |        ├── 01e_ALL_02_postViralVerify.tsv 
    ├── 02_N-01_checkV_Nonintegrated
    |        ├── 02_N-01_00_aggregated_nonintegrated_virus_contigs.tsv
    |        ├── 02_N-01_00_aggregated_nonintegrated_virus_contigs.fna
    |        ├── 02_N-01_01_checkV
    |        ├── 02_N-01_02_postcheckV_nonintegrated_df.tsv
    |        ├── 02_N-01_02_postcheckV_integrated.tsv.fna
    ├── 03_I-01_checkV_Integrated
    |        ├── 03_I-01_00_aggregated_integrated_virus_All_contigs.tsv
    |        ├── 03_I-01_00_aggregated_integrated_virus_All_contigs.fna
    |        ├── 03_I-01_01_checkVIntegrated_1
    |        ├── 03_I-01_02_postcheckV1_integrated_cordf.tsv
    |        ├── 03_I-01_02_postcheckV1_integrated_withmergedprovirIDs_cordf.tsv
    |        ├── 03_I-01_03_merged_integrated.tsv
    |        ├── 03_I-01_03_merged_integrated.fna
    |        ├── 03_I-01_04_checkVIntegrated_2
    |        ├── 03_I-01_05_postcheckV2_integrated_df_p.tsv
    ├── 04_M_Detection
    |        ├── 04_M_00_Mixed_Int_Viruses.tsv 
    |        ├── 04_M_00_Mixed_NonInt_Viruses.tsv
    |        ├── 04_M_01_resolved_NonInt_Viruses.tsv
    |        ├── 04_M_01_resolved_Int_Viruses.tsv
    |        ├── 04_M_02_resolved_nonintegrated.fna
    |        ├── 04_M_02_resolved_nonintegrated_trimmed_DTR.fna
    |        ├── 04_M_02_resolved_integrated.fna
    ├── 05_N-02_phaTYPNonintegrated
    |        ├── 05_N-02_01_phaTYP_out
    |        ├── 05_N-02_02_NonINT_mergedPostCheckV_PhaTYP.tsv
    ├── 06_N-03_geNomad_taxonomy_all_non-integrated_viral_sequences
    |        ├── 06_N-03_02_postgenomad_tax.tsv    
    ├── 07_N-04_FinalThresholding
    |        ├── 07_N-04_Final_Viruses_df.tsv
    |        ├── 07_N-04_Final_Viruses.fna
    |        ├── 07_N-04_Final_Viruses_trimmed_DTR.fna
    ├── 08_I-02_geNomad_taxonomy_all_integrated_viral_sequences
    |        ├──  08_I-02_02_postgenomad_tax.tsv    
    ├── 09_I-03_FinalThresholding
    |        ├── 09_I-03_Final_Viruses_df.tsv
    |        ├── 09_I-03_Final_Viruses.fna
    └── sproj.binary 
```

When files are missing from the project fodler, it means that there were no corresponding viral sequences found.