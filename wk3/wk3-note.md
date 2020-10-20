

the concept of vectors - numeric, character, and logical.

- Vectors are one dimensional matrices; 一维
- matrices have two dimensions; (either numberic **or** character) 二维
- arrays (see below) are n-dimensional matrices. 多维

```
matrices * numeric的计算方式
Seq()，平均数
rep(1:3, each = 5), 重复
this_is_an_array <- array(1:24, dim=c(3,4,2)) #row col n
rbinom()

```

- Lists are data structures which can contain other data structures, 也就是说可以给list里的[]data structures 起name
- csv files are restricted to matrix style data (i.e. data in 2 dimensions, matrices and data.frames), and so cannot store data in arrays or lists
- vroom() can read them(csv) much, much faster (hence the name)

## Find files by “keyword”

```
##find files in the default directory which start with "mtcars" and end in "csv",找开头结尾的文件，管用！
##save these file names as an object called "files"
files <- fs::dir_ls(glob = "mtcars*csv")
```

## Creating pipelines via the magrittr operator %>%

```
#Pipelines take the form of:
my_data %>% function_1() %>% function_2()
#This reads as “take `my_data`, apply `function_1()` to that data, then apply `function_2()` to that data”. But more on that later.
```

## Class（）

```
## [1] "tbl_df"     "tbl"        "data.frame"

The tbl in both of these stand for tibble - which is a kind of data.frame. tibble are the universal data type which the tidyverse use
```

## 7.3 Basic data reshaping with `pivot_`

```
pivot_longer
#opposite
pivot_wider
```





| Function/operator                             | Call                                                         |
| :-------------------------------------------- | :----------------------------------------------------------- |
| Create a matrix                               | `matrix()`                                                   |
| Sequence of regular numbers                   | `seq()`                                                      |
| Dimensions of an object                       | `dim()`                                                      |
| Matrix multiplication                         | `%*%`                                                        |
| Transpose                                     | `t()`                                                        |
| Create matrix where diagonal is filled with x | `diag()`                                                     |
| Return the diagonal of a matrix               | `diag()`                                                     |
| Calculate eighenvalues and eigenvectors       | `eigen()`                                                    |
| Sums of the rows                              | `rowSums()`                                                  |
| Sums of the columns                           | `cowSums()`                                                  |
| Means of the rows                             | `rowMeans()`                                                 |
| Means of the columns                          | `colMeans()`                                                 |
| Make an array                                 | `array()`                                                    |
| Make a data.frame                             | `data.frame()`                                               |
| Make a list                                   | `list()`                                                     |
| Install a package from CRAN                   | `install.packages()`                                         |
| Install a package from Github                 | `install_github()`                                           |
| Load a package into the global environment    | `library()`                                                  |
| Reading in data                               | `vroom()`                                                    |
| Set working directory to file location        | `setwd(dirname(rstudioapi::getActiveDocumentContext()$path))` |
| Check the class of an object                  | `class()`                                                    |
| Change a file from wide to long format        | `pivot_longer()`                                             |
| Change a file from long to wide format        | `pivot_wider()`                                              |