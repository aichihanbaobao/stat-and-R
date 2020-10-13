expr=read.table('co-inhibitors.txt',header = T,stringsAsFactors = TRUE)
t <- aggregate(expr[,3:17], by=list(expr$cluster), FUN = median)
library(pheatmap)
t[1,1]='cluster1'
t[2,1]='cluster2'
t[3,1]='cluster3'
t[4,1]='cluster4'
choose_matrix <- t(t[,2:16])

data=melt(choose_matrix)
data <- data %>%
  mutate(text = case_when(  # 一定要 get 到 case_when() 函数奥秘
    value > 0 ~ paste(round(value, 2), "\n*"), # round() 只保留两位小数
    value <= 0 ~ paste(round(value, 2), "\nns")))

colnames(choose_matrix) <- t$Group.1
pheatmap(choose_matrix,scale = "row",
         color=colorRampPalette(c("RoyalBlue", "white", "Firebrick1"))(100),cluster_cols = F,cluster_rows = F)

###ac=data.frame(g=group_list)
###rownames(ac)=colnames(expr1)
###pheatmap(expr1,show_colnames =F,show_rownames = F,annotation_col=ac) #列名注释信息为ac即分组信息
