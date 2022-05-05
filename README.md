## Movie Recommendation by Genre

This is an unsupervised Clustering Model which clusters movies based on their Genres.

The data for this project was collected from Data World's [IMDB dataset.](https://data.world/mahe432/movies/workspace/file?filename=IMDb%20movies.csv)

The data looks like this.

![dataset](https://user-images.githubusercontent.com/97380339/166904967-d08f25d4-ac30-4a01-9fd3-dee0a3386890.png)

We first filtered the data and used only movies from and after 2018.

Then we convert the data into a corpus and modify it to make it fit for our analysis by converting all text to lower-case, removing white spaces, punctuations, stopwords and such.
Then we stem the document and make a Document Term Matrix.

Now we select 20 random movies from the dataset and run  hierarchical clustering using ward method.
We plot a dendrogram to see how the movies are clustered.


![dendrogram](https://user-images.githubusercontent.com/97380339/166910877-ea00e59c-f683-4082-934f-abc0d7aee2dd.png)


We can see that similar movies are on the same branch.

Now we know that our data has 20 overall genres. So we first make 20 clusters by k-means clustering and plot it.



![20_clusters](https://user-images.githubusercontent.com/97380339/166911572-833d671a-9a24-4ca4-8bec-b32c766a6770.png)

So we can see that some clusters have exceptionally high values. Also, clustering individual data as a set is not ideal.
So we try to find the optimum number of clusters by plotting an Elbow Curve.


![elbow curve](https://user-images.githubusercontent.com/97380339/166911915-4296ff13-2ab2-4d60-b287-07172296fe2c.png)



From the above elbow curve we can see that after 7 clusters the value is more or less the same. And there is very small change.
So we come to the conclusion that 7 is the optimum number of clusters for our data.

Now we again perform K-means Clustering with 7 clusters and plot our results.


![7_clusters](https://user-images.githubusercontent.com/97380339/166912399-2f91d36e-ac94-4511-af11-54ece30fcd14.png)


These are our final 7 clusters of genres which group similar movies together and thus help in recommending movies.
