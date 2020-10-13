options(stringsAsFactors = F)
data1 <- read.table("2TBtools.kaks.tab.txt",stringsAsFactors = FALSE,fill = TRUE,sep = '\t',header = T)
data1 = na.omit(data1)
data1= data1[,3:4]
data1$name='Fragaria ananassa Duc'

data2 <- read.table("3TBtools.kaks.tab.txt",stringsAsFactors = FALSE,fill = TRUE,sep = '\t',header = T)
data2 = na.omit(data2)
data2= data2[,3:4]
data2$name='Pyrus bretschneideri Rehd'

data3 <- read.table("4TBtools.kaks.tab.txt",stringsAsFactors = FALSE,fill = TRUE,sep = '\t',header = T)
data3 = na.omit(data3)
data3= data3[,3:4]
data3$name='Prunus mume'

data4 <- read.table("mm.TBtools.kaks.tab.txt",stringsAsFactors = FALSE,fill = TRUE,sep = '\t',header = T)
data4 = na.omit(data4)
data4= data4[,3:4]
data4$name='Malus domestica'

data5 <- read.table("taoTBtools.kaks.tab.txt",stringsAsFactors = FALSE,fill = TRUE,sep = '\t',header = T)
data5 = na.omit(data5)
data5= data5[,3:4]
data5$name='Prunus persica'

data=rbind(data1,data2,data3,data4,data5)

ks=data[,-1]
ks$name = paste0(ks$name,'-Ks')
colnames(ks)=c('Ks','name')
kaksdata=as.numeric(data$Ka/data$Ks)
ksa=data.frame(cbind(kaksdata,data$name))
colnames(ksa)=c(paste0('Ka/','Ks'),'name')
ksa$`Ka/Ks`=as.numeric(ksa$`Ka/Ks`)
ksa$name = paste0(ksa$name,'-Ka/Ks')

#show_col(hue_pal()(5))

p1 <- ggplot(ks,aes(Ks,color=name))  +
  geom_line(stat="density")  + xlim(0,1)  + theme_bw()  + scale_fill_manual(values=hue_pal()(5)) +
  theme(axis.title = element_text(size=16),axis.text=element_text(size=16))


p2 <- ggplot(ksa,aes(`Ka/Ks`,color=name))  +
  geom_line(stat="density")  + xlim(0,1)  + theme_bw()  + scale_fill_manual(values=hue_pal()(5)) +
  theme(axis.title = element_text(size=16),axis.text=element_text(size=16))

p1
p2

