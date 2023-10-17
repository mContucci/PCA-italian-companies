#Install
install.packages("FactoMineR")
#load
library("FactoMineR")

#Import of the data from 2019 to 2020
Dataset <- read.csv("Data/Data_ind.CSV", 
                  header=TRUE, na = "", sep = ";", stringsAsFactors = TRUE) 

#Visualize the head of the data set
head(Dataset[, c("ID", "ROA", "EBITDA.V" , "ILG", "CCN.ATT", "IND_FIN", "INT_TERZI")])

#Data set ready for PCA analysis
row.names(Dataset) <- as.character(Dataset$ID)
Dataset$ID <- NULL
Dataset <- na.omit(Dataset)
Dataset.PCA <- Dataset[, c("ROA", "EBITDA.V", "ILG", "CCN.ATT", "IND_FIN", "INT_TERZI")]

#PCA 
pca <- PCA(Dataset.PCA , scale.unit=TRUE, ncp=6, graph = FALSE)
print(plot.PCA(pca, axes=c(1, 2), choix="ind", habillage="none", col.ind="black", 
               col.ind.sup="blue", col.quali="magenta", label=c("ind", "ind.sup", "quali"),
               new.plot=TRUE))
print(plot.PCA(pca, axes=c(1, 2), choix="var", new.plot=TRUE, col.var="black", 
               col.quanti.sup="blue", label=c("var", "quanti.sup"), lim.cos2.var=0))

summary(pca, nb.dec = 3, nbelements=10, nbind = 10, ncp = 3, file="")

remove(Dataset.PCA)
pca$eig
pca$var$cor