library(devtools)
library(Rcpp)
library(plyr)
require(rCharts)
require(googleVis)


EPA_Contaminant_Diseases <- read.csv(file="EPA_Water_Contaminants.csv",
							header=TRUE,sep=",",stringsAsFactors=FALSE)

ContaminantDiseaseCount <- count(EPA_Contaminant_Diseases, 
                                 c('ContaminantType','PotentialHealthEffect'))

M <- gvisSankey(ContaminantDiseaseCount, from="ContaminantType", 
                to="PotentialHealthEffect", weight="freq",
                options=list(
                  height=600, width=1000,
                  sankey="{link:{color:{fill:'lightblue'}}}"
                ))

#plot(M)
cat(M$html$chart, file="SankeyContaminant.html")