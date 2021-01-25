#Test Cell type specificity calculations Aif1, Pvalb
test_that("Cell type specificity Aif1, Pvalb", {
  #inspect specificity matrix for type 1 cell types from generate.celltype.data
  #Use Vignette Dataset to check function output
  data(cortex_mrna)
  if(!file.exists("MRK_List2.rpt")){
    download.file("http://www.informatics.jax.org/downloads/reports/MRK_List2.rpt", destfile="MRK_List2.rpt")
  }
  nKeep = 1000
  must_keep = c("Apoe","Gfap","Gapdh","Pvalb","Aif1")
  set.seed(123458)
  keep_genes = c(must_keep,sample(rownames(cortex_mrna$exp),995))
  cortex_mrna$exp = cortex_mrna$exp[keep_genes,]
  
  #Note not normalising data to save time
  
  exp_CortexOnly_DROPPED = drop.uninformative.genes(exp=cortex_mrna$exp,#_scT_normed,
                                                    level2annot = cortex_mrna$annot$level2class)
  annotLevels = list(level1class=cortex_mrna$annot$level1class,level2class=cortex_mrna$annot$level2class)
  fNames_CortexOnly = generate.celltype.data(exp=exp_CortexOnly_DROPPED,annotLevels=annotLevels,groupName="kiCortexOnly")
  
  #filter only orthologs
  fNames_CortexOnly = filter.genes.without.1to1.homolog(fNames_CortexOnly)
  
  #load and inspect specificity matrix
  load(fNames_CortexOnly[1])
  
  EWCE_return_Pvalb <- sort(ctd[[1]]$specificity["Pvalb",],decreasing=TRUE)
  EWCE_return_Aif1 <- sort(ctd[[1]]$specificity["Aif1",],decreasing=TRUE)
  
  pvalb_interneurons <- names(EWCE_return_Pvalb)[[1]] =="interneurons"
  aif1_microglia <- names(EWCE_return_Aif1)[[1]] =="microglia"
  
  # fail if most specific cell type for Aif1, Pvalb not microglia and interneurons respectively
  expect_equal(all(pvalb_interneurons,aif1_microglia),TRUE)
})