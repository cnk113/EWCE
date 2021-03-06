% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prep_dendro.r
\name{prep_dendro}
\alias{prep_dendro}
\title{prep_dendro}
\usage{
prep_dendro(ctdIN)
}
\arguments{
\item{ctdIN}{A single annotLevel of a ctd, i.e. ctd[[1]] (the function is 
intended to be used via apply)}
}
\value{
A ctd with dendrogram plotting info added
}
\description{
\code{prep_dendro} adds a dendrogram to a cts
}
\examples{
library(ewceData)
ctd <- ctd()
ctd <- lapply(ctd, EWCE::bin_specificity_into_quantiles, numberOfBins = 40)
ctd <- lapply(ctd, EWCE::prep_dendro)
}
