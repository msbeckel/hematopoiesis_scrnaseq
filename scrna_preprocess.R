#############################################################################################
# Aim: preprocess rawdata located in /data/basal_bone_marrow and make data/sce.Rds
# Author: Maximiliano S. Beckel
# Creation: 2024/02/26
# Last modification: 2024/02/26
#############################################################################################

# Set wd
setwd("/home/maxibeckel/github/hematopoiesis_scrnaseq")

# Load Libraries
suppressPackageStartupMessages(library(SingleCellExperiment))

# Import data
rawdata <- Matrix::readMM("./data/basal_bone_marrow/basal_bone_marrow.raw_counts.mtx.gz")
metadata <- read.csv("./data/basal_bone_marrow/basal_bone_marrow.metadata.csv")
genes <- read.table("./data/basal_bone_marrow/genes.txt")

# Make sce object and filter cells
sce <- SingleCellExperiment(assays = list(counts = t(rawdata)), colData = metadata)
sce <- sce[, as.logical(colData(sce)$pass_filter)]

# Export SCE object
saveRDS(sce, file = "./data/sce.rds")