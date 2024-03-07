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
clus <- t(read.csv("./data/cell_groupings.csv", header = FALSE))
colnames(clus) <- clus[1, ]
clus <- clus[-1, ]

# Make sce object and filter cells
sce <- SingleCellExperiment(assays = list(counts = t(rawdata)), colData = metadata)

# cells and genes names
rownames(sce) <- genes[, 1]
colnames(sce) <- metadata[, "cell_id"]

# Filter cells
sce <- sce[, as.logical(colData(sce)$pass_filter)]

# Add coordinated from KNN
coord <- read.csv("data/coordinates.txt", header = FALSE, row.names = colnames(sce))
reducedDim(sce, "SPRING") <- coord[, c(2, 3)]

# Add louvain clusters
colData(sce)[, "louvain"] <- factor(clus[, "Louvain cluster"], levels = as.character(seq(0, 11)))

# Export SCE object
saveRDS(sce, file = "./data/sce.rds")
