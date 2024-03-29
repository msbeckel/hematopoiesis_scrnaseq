#############################################################################################
# Aim: make scX analysis and deploy shiny app
# Author: Maximiliano S. Beckel
# Creation: 2024/02/26
# Last modification: 2024/02/26
#############################################################################################
# Library ----
suppressPackageStartupMessages(library(scX))
# Loading SCE object ----
sce <- readRDS("/home/data/sce.rds")

# Filter basal_bm1
sce <- sce[, sce$library_id != "basal_bm1"]

# Preprocess
cseo <- createSCEobject(
    xx = sce,
    partitionVars = "louvain",
    metadataVars = c(
        "library_id", "seq_run_id",
        "PBA_Potential", "PBA_Prob_E", "PBA_Prob_GN",
        "PBA_Prob_Ly", "PBA_Prob_D", "PBA_Prob_Meg",
        "PBA_Prob_M", "PBA_Prob_Ba"
    ),
    descriptionText = "Tusi 2018 Haematopoiesis dataset"
)

launch_scX(cseo, point.size = 50, port = 9192, host = "0.0.0.0", launch.browser = F)
