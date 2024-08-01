# Detailed outputs

All the outputs from an individual sample are saved within its corresponding folder. Outputs are grouped into subfolders corresponding to the step that generated them, with their names beeing suggestive for the respective step. Such a project folder is exemplified below.  

```plaintext
single_workflow_project_name/ 
    ├──  ALL_00_min_length_#
    |        ├── outMFasta_small.fna   
    ├──  ALL-01a_genomad
    |        ├── ALL-01a_01_genomad_out
    |        ├── ALL-01a_02_postgenomad_integrated_df.tsv
    |        ├── ALL-01a_02_postgenomad_nonintegrated_df.tsv
    ├── ALL-01b_DVF
    |        ├── ALL-01b_01_DVF_out
    |        ├── ALL-01b_postdfvf_nonintegrated_df.tsv
    ├── ALL-01c_virSorter2
    |        ├── ALL-01c_01_virSorter2_out
    |        ├── ALL-01c_02_postVS2_integrated_df.tsv
    |        ├── ALL-01c_02_postVS2_nonintegrated_df.tsv
    ├── ALL-01d_vibrant
    |        ├── ALL-01d_01_vibrant_out
    |        ├── ALL-01d_02_postvibrant_integrated_df.tsv
    |        ├── ALL-01d_02_postvibrant_nonintegrated_df.tsv
    ├── ALL-01e_viralVerify
    |        ├── ALL-01e_01_viralVerify_out
    |        ├── ALL-01e_02_postViralVerify.tsv 
    ├── I-02_checkV_Integrated
    |        ├── I-02_00_aggregated_integrated_virus_All_contigs.tsv
    |        ├── I-02_00_aggregated_integrated_virus_All_contigs.fna
    |        ├── I-02_01_checkVIntegrated_1
    |        ├── I-02_02_postcheckV1_integrated_cordf.tsv
    |        ├── I-02_02_postcheckV1_integrated_withmergedprovirIDs_cordf.tsv
    |        ├── I-02_03_merged_integrated.tsv
    |        ├── I-02_03_merged_integrated.fna
    |        ├── I-02_04_checkVIntegrated_2
    |        ├── I-02_05_postcheckV2_integrated_df_p.tsv
    ├── I-03_FinalThresholding
    |        ├── I-03_Final_Viruses_df.tsv
    |        ├── I-03_Final_Viruses.fna
    ├── M-02_Detection
    |        ├── M-02_Mixed_Int_Viruses.tsv
    |        ├── M-02_Mixed_NonInt_Viruses.tsv
    ├── N-02_checkV_Nonintegrated
    |        ├── N-02_00_aggregated_nonintegrated_virus_contigs.tsv
    |        ├── N-02_00_aggregated_nonintegrated_virus_contigs.fna
    |        ├── N-02_01_checkV
    |        ├── N-02_02_postcheckV_nonintegrated_df.tsv
    |        ├── N-02_02_postcheckV_nonintegrated.fna
    ├── N-03_phaTYPNonintegrated
    |        ├── N-03_01_phaTYP_out
    |        ├── N-03_02_NonINT_mergedPostCheckV_PhaTYP.tsv
    ├── N-04_FinalThresholding
    |        ├── N-04_Final_Viruses_df.tsv
    |        ├── N-04_Final_Viruses.fna
    └── sproj.binary 
```

