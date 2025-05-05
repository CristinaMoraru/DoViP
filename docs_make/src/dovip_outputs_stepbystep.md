# Outputs - step by step breakdown


## Removal of small contigs

Initialy, DoViP removes from the input file all contigs smaller than `min_contig_length`. The resulting fasta file is saved a folder with the sufix coresponding to `min_contig_length`, as shown below. 
```plaintext
single_workflow_project_name/ 
    ├──  00_ALL_min_length_#   (#=`min_contig_length`)
    |        ├── outMFasta_small.fna  
    ├──  ... 
```

## Running initial predictors
The .fna file from the removal of small contigs step is sent to each of the initial predictions selected by the user. The results from each intial predictor are saved into folders with corresponding names, within subfolders labeled with the sufix `_out`. The "raw" data from each predictor are further postprocessed by DoViP and saved saved in two .tsv files, one for the integrated viruses branch (geNomad, VirSorter2 and VIBRANT), and the other for the non-integrated viruses branch (geNomad, DeepVir Finder, VirSorter2, VIBRANT and ViralVerify). The two .tsv files are saved directly in these folders, as shown below.  

```plaintext
single_workflow_project_name/ 
    ├──  ... 
    ├──  01a_ALL_genomad
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
    ├──  ... 
```



## Merging and checkV for non-integrated viruses
In this step, DoViP first brings toghether all virus contigs estimated as lytic by the various predictors and their associated information, and saves them in a .tsv and a .fna file with the prefix `02_N-01_00`. The .fna file then is inputed in CheckV, and the results are saved in the `02_N-01_01_CheckV` folder. Postprocessing after checkV includes saving the contigs marked as containing integrated viruses (they will be inputed in the integrated viruses branch) and then saving the remaining non-integrated viruses and their coresponding information in a .tsv file (prefix `02_N-01_02`). The folder structure and outputs are shown below.  

```plaintext
single_workflow_project_name/ 
    ├── ...       
    ├── 02_N-01_checkV_Nonintegrated
    |        ├── 02_N-01_00_aggregated_nonintegrated_virus_contigs.tsv
    |        ├── 02_N-01_00_aggregated_nonintegrated_virus_contigs.fna
    |        ├── 02_N-01_01_checkV
    |        ├── 02_N-01_02_postcheckV_nonintegrated_df.tsv
    |        ├── 02_N-01_02_postcheckV_integrated.tsv.fna
    ├──  ... 
```

## Merging and checkV for integrated viruses
In this step DoViP does the following:
  * brings together all virus contigs estimated as "temperate" by the various predictors (including those from the 02_N-01 step, predicted by CheckV as integrated), and saves them in a .fna and a .tsv file with the prefix `03_I-01_00`.
  * inputs the .fna file in CheckV, and saves the results in the `03_I-01_01_checkVIntegrated_1` folder.
  * uses the information from the initial predictors and CheckV to remove host regions and to merge overlapping viral regions, and saved the them in a .fna and .tsv file with the prefix `03_I-01_03` (the filex with I_02_02 represent intermediary results).
  * sends the merged integrated viruses to CheckV, and saves the data in the folder `03_I-01_04_checkVIntegrated_2`
  * postprocesses the output from the second CheckV step to confirm that no host-contamination is present and to add the completeness and other checkV data to the merged integrated viruses. The data are saved in the file with the `03_I-01_05` prefix.
  
```plaintext
single_workflow_project_name/ 
    ├── ...
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
    ├──  ... 
```

## unMixing viruses
It can happen that the same contig is identified by some initial predictors as non-integrated viruses and by some other predictors as harboring integrated viruses. In the "unMixing viruses" step, DoViP does the following:
  * it uses `02_N-01_02_postcheckV_nonintegrated_df.tsv` and `03_I-01_05_postcheckV2_integrated_df_p.tsv` files to identify these mixed predictions, and reports them in the `M_02_Detection` folder (see files with the prefix `04_M_00`).   
  * it considers all "mixed" contigs coming from the non-integrated as truly non-integrated, because CheckV found no host contamination present. Furtheremore, DoViP considers all "mixed" viral sequences comming from the integrated branch as beeing incorectly labeled as integrated. Therefore, for the "mixed" contigs, DoViP merges the integrated and non-integrated predictions by transfering the intial predictors from the integrated branch to the nonintegrated virus contigs. This will increase the number of initial predictors for a partticular contig, increasing therefore its chance to pass the thresholds from the final step. The new information on the non-integrated viruses will be saved in  `04_M_01_resolved_NonInt_Viruses.tsv`, `04_M_02_resolved_nonintegrated.fna` and `04_M_02_resolved_nonintegrated_trimmed_DTR.fna`.   
  * it removes all "mixed" viral contigs from the `03_I-01_05_postcheckV2_integrated_df_p.tsv`, and the updated integrated viruses are saved in `04_M_01_resolved_Int_Viruses.tsv` and `04_M_02_resolved_integrated.fna`.      

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── 04_M_Detection
    |        ├── 04_M_00_Mixed_Int_Viruses.tsv 
    |        ├── 04_M_00_Mixed_NonInt_Viruses.tsv
    |        ├── 04_M_01_resolved_NonInt_Viruses.tsv
    |        ├── 04_M_01_resolved_Int_Viruses.tsv
    |        ├── 04_M_02_resolved_nonintegrated.fna
    |        ├── 04_M_02_resolved_nonintegrated_trimmed_DTR.fna
    |        ├── 04_M_02_resolved_integrated.fna
    └── ...
```

## Predicting virus lifestyles with PhaTYP
In this step DoViP sends the non-integrated viruses from the previous step (`04_M_02_resolved_nonintegrated.fna`) to PhaTYP, which predicts their potential life styles. The PhaTYP results are saved in the folder with the `_out` suffix. The predictions are then added to the previous data and saved in the .tsv file with the `05_N-02_02` prefix.

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── 05_N-02_phaTYPNonintegrated
    |        ├── 05_N-02_01_phaTYP_out
    |        ├── 05_N-02_02_NonINT_mergedPostCheckV_PhaTYP.tsv
```

## Taxonomic assignment of non-integrated viral sequences
Here DoviP sends the non-integrated viruses from the unMixing viruses step (`04_M_02_resolved_nonintegrated.fna`) to geNomad, to predicting their taxonomy (including for the viral sequences predicted by other initial predictors than geNomad). The taxonomic predictions are added then to the output table from the PhaTYP step (`05_N-02_02_NonINT_mergedPostCheckV_PhaTYP.tsv`).  
```
    ├── 06_N-03_geNomad_taxonomy_all_non-integrated_viral_sequences
    |        ├── 06_N-03_02_postgenomad_tax.tsv    
```

## Final virus selection - non-integrated virus branch
DoViP uses data in the `06_N-03_02_postgenomad_tax.tsv` file to perform a final selection of the non-integrated virus contigs based on their completeness and the number of initial predictors. The results are saved as .fna and .tsv file, as shown below. 

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── 07_N-04_FinalThresholding
    |        ├── 07_N-04_Final_Viruses_df.tsv
    |        ├── 07_N-04_Final_Viruses.fna
    |        ├── 07_N-04_Final_Viruses_trimmed_DTR.fna
    └── ...
```

## Taxonomic assignment of integrated viral sequences
Here DoviP sends the integrated viruses from the unMixing viruses step (`04_M_02_resolved_integrated.fna`) to geNomad, to predicting their taxonomy (including for the viral sequences predicted by other initial predictors than geNomad).  The taxonomic predictions are added then to the output table from the unMixing viruses step (`04_M_01_resolved_Int_Viruses.tsv`).  
```
    ├── 08_I-02_geNomad_taxonomy_all_integrated_viral_sequences
    |        ├──  08_I-02_02_postgenomad_tax.tsv        
```

## Final virus selection - integrated virus branch
DoViP uses data in the `08_I-02_02_postgenomad_tax.tsv` file to perform a final selection of the integrated virus contigs based on their completeness and the number of initial predictors. The results are saved as .fna and .tsv file, as shown below. 

```plaintext
single_workflow_project_name/ 
    ├── ...
    ├── 09_I-01_FinalThresholding
    |        ├── 09_I-03_Final_Viruses_df.tsv
    |        ├── 09_I-03_Final_Viruses.fna
    └── ...
```





