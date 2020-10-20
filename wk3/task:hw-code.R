#Task1
#Make a matrix of 80 random numbers drawn from a normal distribution (see the function rnorm()). You can decide on the values for mean and sd, and the dimensions of the matrix.

t1=rnorm(80, mean = 0, sd = 1)
dim(t1)=c(8,10)
class(t1)
View(t1)

#Task2
#create an array containing 100 random numbers drawn from a uniform distribution (see runif()) with at least 3 groups. Consider the limitations in terms of the dimensions you can specify given the length of the data you are adding to the matrix.

t2=array(runif(100, min = 0, max = 1),dim=c(2,5,10))
t2

# Homework
#As with last week, the first thing to do is to ensure you have gone through - and understood - the information above in full.
#Write an Rmarkdown describing how you do the following:
#  load to_sort_pop_1.csv and to_sort_pop_1.csv from bioinformatics_data on github.
#these data are population counts for endangered species. The first four columns should be self explanitory (the species binomial, and the primary, secondary, and tertiary threat each species is being threatened by). The rest of the columns specify the population counts for given dates. If you compare the two data (to_sort_pop_1.csv vs to_sort_pop_1.csv) you will see that the population is specified in the names of the date columns.

#do the above with the minimum amount of code (hint - %>%!)
#In your RMarkdown make sure you explain what you have done and show your annotated code.

#load the csv files

to_sort_pop_1 <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/to_sort_pop_1.csv")
to_sort_pop_1 <- cbind(to_sort_pop_1[,1:4],"population"=1,to_sort_pop_1[,5:ncol(to_sort_pop_1)])
to_sort_pop_2 <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/to_sort_pop_2.csv")
to_sort_pop_2 <- cbind(to_sort_pop_2[,1:4],"population"=2,to_sort_pop_2[,5:ncol(to_sort_pop_2)])

#using tidyverse join both of these data together into a single tibble
st <- to_sort_pop_1 %>% full_join(to_sort_pop_2,by= c("species","primary_threat","secondary_threat","tertiary_threat","population"))

#reshape them from wide to long format
st_long <- st %>%
  pivot_longer(cols = -c(species:population),
               names_to = "date",
               values_to = "abundance")
#make sure when you do this that you end up with (1) a column specifying which population the data are from (i.e. population 1 or 2), (2) a column specifying the date the data were collected, (3) a column with the population abundance estimates in it, and (4) that any missing values are dropped from the data. I.e. your data.frame should look like the figure below.

st_long_1=st_long[-which(is.na(st_long$abundance)),]
st_long_1

# A tibble: 696 x 7
species                    primary_threat      secondary_threat tertiary_threat population date             abundance
<chr>                      <chr>               <chr>            <chr>                <dbl> <chr>                <dbl>
  1 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2013-01-01       353
2 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2014-01-01       419
3 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2015-01-01       359
4 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2016-01-01       363
5 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2017-01-01       321
6 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2018-01-01       280
7 Schistidium helveticum     Habitat destruction NA               NA                       1 pop_1_2019-01-01       379
8 Paraleucobryum longifolium Exploitation        Habitat loss     NA                       1 pop_1_2005-01-01        24
9 Paraleucobryum longifolium Exploitation        Habitat loss     NA                       1 pop_1_2006-01-01        12
10 Paraleucobryum longifolium Exploitation        Habitat loss     NA                       1 pop_1_2007-01-01        18
# … with 686 more rows
