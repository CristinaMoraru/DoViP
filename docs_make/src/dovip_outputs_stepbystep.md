# Outputs - step by steps breakdown


## Removal of small contigs

Initialy, DoViP removes from the input file all contigs smaller than `min_contig_length`. The resulting fasta file is saved a folder with the sufix coresponding to `min_contig_length`, as shown below. 
```plaintext
single_workflow_project_name/ 
    ├──  ALL_00_min_length_#   (#=`min_contig_length`)
    |        ├── outMFasta_small.fna  
    ├──  ... 
```

## Running initial predictors
The .fna file from the removal of small contigs step is sent to each of the initial predictions selected by the user. The results from each intial predictor are saved into folders with corresponding names, within subfolders labeled with the sufix "_out". The "raw" data from each predictor are further postprocessed by DoViP and saved saved in two .tsv files, one for the integrated viruses branch (geNomad, VirSorter2 and VIBRANT), and the other for the non-integrated viruses branch (geNomad, DeepVir Finder, VirSorter2, VIBRANT and ViralVerify). The two .tsv files are saved directly in these folders, as shown below.  

```plaintext
single_workflow_project_name/ 
    ├──  ... 
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
    ├──  ... 
```



## Merging and checkV for non-integrated viruses
In this step, DoViP first brings toghether all virus contigs estimated as lytic by the various predictors and their associated information, and saves them in a .tsv and a .fna file with the prefix N-02_00. The .fna file then is inputed in CheckV, and the results are saved in the `N-02_01_CheckV` folder. Postprocessing after checkV includes moving of the contigs marked as containing integrated viruses on the integrated viruses branch and then saving the remaining non-integrated viruses and their coresponding information in a .tsv and .fna file (prefix N-02_-2..). The folder structure and outputs are shown below.  

```plaintext
single_workflow_project_name/ 
    ├── ...       
    ├── N-02_checkV_Nonintegrated
    |        ├── N-02_00_aggregated_nonintegrated_virus_contigs.tsv
    |        ├── N-02_00_aggregated_nonintegrated_virus_contigs.fna
    |        ├── N-02_01_checkV
    |        ├── N-02_02_postcheckV_nonintegrated_df.tsv
    |        ├── N-02_02_postcheckV_nonintegrated.fna
    ├──  ... 
```

## Merging and checkV for integrated viruses
In this step DoViP does the following:
  * brings together all virus contigs estimated as "temperate" by the various predictors, and saved them in a .fna and a .tsv file with the prefix I-02_00.
  * inputs the .fna file in CheckV, and saves the results in the `I-02_01_checkVIntegrated_1` folder.
  * uses the information from the initial predictors and CheckV to remove host regions and to merge overlapping viral regions, and saved the them in a .fna and .tsv file with the prefix I-02_03 (the filex with I_02_02 represent intermediary results).
  * sends the merged integrated viruses to CheckV, and saves the data in the folder `I-02_04_checkVIntegrated_2`
  * postprocesses the output from the second CheckV step to confirm that no host-contamination is present and to add the completeness and other checkV data to the merged integrated viruses. The data are saved in the file with the I-02_05 prefix.
  
```plaintext
single_workflow_project_name/ 
    ├── ...
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
    ├──  ... 
```

## Predicting virus lifestyles with PhaTYP
In this step DoViP sends the non-integrated viruses from the previous step (N-02_02_postcheckV_nonintegrated.fna) to PhaTYP, which predicts their potential life styles. The PhaTYP results are saved in the folder with the `_out` suffix. The predictions are then added to the previous data and saved in the .tsv file with the N-03_02 prefix.

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── N-03_phaTYPNonintegrated
    |        ├── N-03_01_phaTYP_out
    |        ├── N-03_02_NonINT_mergedPostCheckV_PhaTYP.tsv
```

## Final virus selection - non-integrated virus branch
DoViP uses data in the `N-03_02_NonINT_mergedPostCheckV_PhaTYP.tsv` file to perform a final selection of the non-integrated virus contigs based on their completeness and the number of initial predictors. The results are saved as .fna and .tsv file, as shown below. 

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── N-04_FinalThresholding
    |        ├── N-04_Final_Viruses_df.tsv
    |        ├── N-04_Final_Viruses.fna
    └── ...
```

## Final virus selection - non-integrated virus branch
DoViP uses data in the `I-02_05_postcheckV2_integrated_df_p.tsv` file to perform a final selection of the integrated virus contigs based on their completeness and the number of initial predictors. The results are saved as .fna and .tsv file, as shown below. 

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── I-03_FinalThresholding
    |        ├── I-03_Final_Viruses_df.tsv
    |        ├── I-03_Final_Viruses.fna
    └── ...
```

## Mixed viruses
It can happen that the same contig is identified by some initial predictors as non-integrated viruses and by some other predictors as harboring integrated viruses. DoViP identifies these mixed predictions and reports them in the `M_02_Detection` folder. The contigs reported in the two .tsv files, one for non-integrated branch and the other for the integrated branch, should be the same.

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── M-02_Detection
    |        ├── M-02_Mixed_Int_Viruses.tsv
    |        ├── M-02_Mixed_NonInt_Viruses.tsv
    └── ...
```


