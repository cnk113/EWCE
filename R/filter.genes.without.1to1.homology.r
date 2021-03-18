#' filter.genes.without.1to1.homolog
#'
#' \code{filter.genes.without.1to1.homolog} Takes the filenames of 
#' celltype_data files, loads them, and drops any genes
#' which don't have a 1:1 homolog based on biomart. The new files are saved to 
#' disc, appending '_1to1only' to the file
#' tag of the previous file.
#'
#' @param filenames Array of filenames for sct_data saved as .Rda files
<<<<<<< HEAD
#' @param savePath Directory where the CTD file should be saved
=======
>>>>>>> origin/master
#' @return Array of filenames included the ones with only 1:1 homologs
#' @examples
#' library(ewceData)
#' # Load the single cell data
#' cortex_mrna <- cortex_mrna()
#' expData <- cortex_mrna$exp
#' expData <- expData[1:500, ] # Use only a subset to keep the example quick
#' l1 <- cortex_mrna$annot$level1class
#' l2 <- cortex_mrna$annot$level2class
#' annotLevels <- list(level1class = l1, level2class = l2)
#' fNames_ALLCELLS <- generate.celltype.data(exp = expData, 
#'     annotLevels = annotLevels, 
<<<<<<< HEAD
#'     groupName = "allKImouse",
#'     savePath=tempdir())
#' fNames_ALLCELLS <- filter.genes.without.1to1.homolog(fNames_ALLCELLS, 
#'     savePath=tempdir())
=======
#'     groupName = "allKImouse")
#' fNames_ALLCELLS <- filter.genes.without.1to1.homolog(fNames_ALLCELLS)
>>>>>>> origin/master
#' @export
#' @import utils
#' @import stringr
#' @import ewceData
<<<<<<< HEAD
filter.genes.without.1to1.homolog <- function(filenames, savePath="~/") {
=======
filter.genes.without.1to1.homolog <- function(filenames) {
>>>>>>> origin/master
    newFilenames <- filenames
    # data("mouse_to_human_homologs")
    mouse_to_human_homologs <- ewceData::mouse_to_human_homologs()
    orthologs <- mouse_to_human_homologs
    mgi_1to1 <- orthologs$MGI.symbol
    hgnc_1to1 <- orthologs$HGNC.symbol
    for (ff in filenames) {
        load(ff)
        sct_genes <- rownames(ctd[[1]]$mean_exp)
        # If it's a m
        if (sum(sct_genes %in% orthologs$MGI.symbol) > 
                sum(sct_genes %in% orthologs$HGNC.symbol)) {
            symbol_1to1_in_sct <- mgi_1to1[mgi_1to1 %in% sct_genes]
        } else {
            symbol_1to1_in_sct <- hgnc_1to1[hgnc_1to1 %in% sct_genes]
        }
        ctd[[1]]$mean_exp <- ctd[[1]]$mean_exp[symbol_1to1_in_sct, ]
        ctd[[1]]$specificity <- ctd[[1]]$specificity[symbol_1to1_in_sct, ]
        # ff2 = gsub("_level","_1to1only_level",ff)
        ff2 <- gsub("\\.rda", "_1to1only\\.rda", ff)
        save(ctd, file = ff2)
        newFilenames <- c(newFilenames, ff2)
    }
    return(newFilenames)
}
