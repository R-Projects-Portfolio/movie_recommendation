install.packages("factoextra")
install.packages("fpc")
install.packages("cluster")

library(tm)
library(NLP)
library(tidyverse)
library(factoextra)
library(fpc)
library(cluster)
library(readxl)
library(dplyr)


#importing data
data <- read_excel("C:\\Users\\HP\\OneDrive\\Documents\\Projects\\Datasets for Projects\\R\\imdb.xlsx", sheet = "cleaned")
glimpse(data)

data_1 <- data %>% filter(year >= 2018)
#load corpus
corpus <- Corpus(VectorSource(data_1$genre))

#inspecting corpus
inspect(corpus)

#to lower case
corpus_1 <- tm_map(corpus, content_transformer(tolower))

#remove punctuation
corpus_2 <- tm_map(corpus_1, removePunctuation)

#remove stopwords
corpus_3 <- tm_map(corpus_2, removeWords, stopwords('english'))

#remove whitespace
corpus_4 <- tm_map(corpus_3, stripWhitespace)

#stemming
corpus_5 <- tm_map(corpus_4, stemDocument)

#document term matrix
dtm <- DocumentTermMatrix(corpus_5)

glimpse(dtm)

dtm
dtm[1:10, 1:5]
rownames(dtm) <- data_1$title

#selecting random 20 movies
set.seed(123)
sample_size <- sample(nrow(data_1), 20, replace = FALSE)
dtm.20 <- dtm[sample_size,]

m_20 <- as.matrix(dtm.20)

#compute distance between vectors
d <- dist(m_20)

#run hierarchical clustering using ward method
groups <- hclust(d, method = 'ward.D')
d_1 <- as.matrix(dtm)

#plotting dendogram
plot(groups, hang = -1)

#k-means clustering
k.means <- kmeans(dist(d_1), 20)

#bar plot
movies.kmeans <- cbind(data_1, k.means$cluster)

names(movies.kmeans)
names(movies.kmeans)[names(movies.kmeans) == 'k.means$cluster'] <- "cluster"

kmeans.percent <- vector()
for(i in 1:20){
  kmeans.percent[i] <- round(k.means$size[i]/ sum(k.means$size) * 100, 3)
}

kmeans.size <- data.frame(group = 1:20, size = k.means$size)

ggplot(kmeans.size, aes(x = group, y = size, fill = factor(group))) + geom_bar(stat = 'identity') + theme(legend.position =  "none") + geom_text(aes(label = paste(size, paste(kmeans.percent, "%", sep = ""), sep = '\n')), vjust = 0.5, size = 4) + scale_x_discrete(limits = kmeans.size$group)
 
#determining optimum no. of clusters
k <- 1:20
wss_values <- map_dbl(k, function(k){kmeans(d_1, k)$tot.withinss})
plot(k, wss_values, 
     type = 'b', pch = 19, frame = F)

#so we find out that 7 is the optimum number of clusters.
kmeans7 <- kmeans(dist(d_1), 7)

#bar plot
movies.kmeans7 <- cbind(data_1, kmeans7$cluster)

names(movies.kmeans7)
names(movies.kmeans7)[names(movies.kmeans7) == 'kmeans7$cluster'] <- "cluster"
movies.kmeans7
kmeans.percent7 <- vector()
for(i in 1:7){
  kmeans.percent7[i] <- round(kmeans7$size[i]/ sum(kmeans7$size) * 100, 3)
}

kmeans.size7 <- data.frame(group = 1:7, size = kmeans7$size)

ggplot(kmeans.size7, aes(x = group, y = size, fill = factor(group))) + geom_bar(stat = 'identity') + theme(legend.position =  "none") + geom_text(aes(label = paste(size, paste(kmeans.percent7, "%", sep = ""), sep = '\n')), vjust = 0.5, size = 4) + scale_x_discrete(limits = kmeans.size7$group)

cluster_1 <- movies.kmeans7[movies.kmeans7$cluster == 1, c('title', 'genre')]
cluster_2 <- movies.kmeans7[movies.kmeans7$cluster == 2, c('title', 'genre')]
cluster_3 <- movies.kmeans7[movies.kmeans7$cluster == 3, c('title', 'genre')]
cluster_4 <- movies.kmeans7[movies.kmeans7$cluster == 4, c('title', 'genre')]
cluster_5 <- movies.kmeans7[movies.kmeans7$cluster == 5, c('title', 'genre')]
cluster_6 <- movies.kmeans7[movies.kmeans7$cluster == 6, c('title', 'genre')]
cluster_7 <- movies.kmeans7[movies.kmeans7$cluster == 7, c('title', 'genre')]

cluster_1
cluster_2
cluster_3
cluster_4
cluster_5
cluster_6
cluster_7
