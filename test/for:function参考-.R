rm(list = ls())  ## 魔幻操作，一键清空~
options(stringsAsFactors = F)
#读取表达矩阵
exprall=read.csv('expression_matrix20200715.csv',)
exprall=exprall[,-c(1:2)]
dim(exprall)

#去除重复基因/重复探针
ids=exprall
ids$median=apply(exprall[,-1],1,median)
ids=ids[order(ids$Description,ids$median,decreasing = T),]#按照median排序每行基因表达
ids=ids[!duplicated(ids$Description),]#去除低表达的同一基因
rownames(ids)=ids$Description#行名为基因名
exprall=ids[,2:18]#17个样本
colnames(exprall)
boxplot(exprall)
exprall=log2(exprall+1)#对数化
library(limma)
exprall=normalizeBetweenArrays(exprall)
boxplot(exprall,las=2)
dat=exprall
#定义函数

deg = function(exprSet,design,contrast.matrix){
  ##step1
  fit <- lmFit(exprSet,design)
  ##step2
  fit2 <- contrasts.fit(fit, contrast.matrix) 
  fit2 <- eBayes(fit2)  ## default no trend !!!
  ##step3
  tempOutput = topTable(fit2, coef=1, n=Inf)
  nrDEG = na.omit(tempOutput) 
  #write.csv(nrDEG2,"limma_notrend.results.csv",quote = F)
  head(nrDEG)
  return(nrDEG)
}

save(deg1,deg2,deg3,deg4,deg5,deg6,deg7,file = 'degall.Rdata')

#设计函数，调用外部变量名
rm(list = ls())  ## 魔幻操作，一键清空~
options(stringsAsFactors = F)
load('degall.Rdata')
#取出七组的上下游差异基因top10
x=c(paste0('x',1:7))
deg=c(paste0('deg',1:7))
topdeg=c(paste0('topdeg',1:7))
for (i in 1:7) { 
  x[i]=data.frame(get(deg[i])$logFC)#deg取logFC这列并将其重新赋值给x
  names(x[[i]])=rownames(get(deg[[i]]))#deg取基因名这列，并将其作为名字给x
  topdeg[i]=data.frame(c(names(head(sort(x[[i]]),10)),names(tail(sort(x[[i]]),10))))
}


topdeg=data.frame(topdeg)
colnames(topdeg)=c(1:7)
write.csv(topdeg,file = 'topdeg1-7.csv')#保存上下游top10基因

#取交集
