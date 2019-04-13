library('Cairo')

data1 <- read.table('times.txt', header = FALSE)


cairo_ps("eredmeny.ps", width=20, height=12)
#cairo_pdf("eredmeny.pdf", width=20, height=12)

#ez csak azért kell, hogy az y tengelyen szép formában legyenek a feliratok
options(scipen=5)
#data table szűrése: [,]-belül első arg a kiválasztott sor(ok), második a kiválasztott oszlop(ok)  
#ylim azért 0.001 mert 0 nem lehet, log(0) miatt (logaritmikus skála!)

plot(data1[1:3,3:2], ylim=c(min(data1[1:9,2]),max(data1[1:9,2])), col="red", type="l",log = "x",xlab="Random számok mennyisége", ylab="Idő", main="Erasztothenészi prímkeresés párhuzamosítása logaritmikus skálán ábrázolva")
rw <- rep('NULL',3)
rw[c(3)] <- 'integer'
rows <- read.table('times.txt', header = FALSE, colClasses=rw)
rows <- as.numeric(unlist(rows))
cl <- rep('NULL',3)
cl[c(2)] <- 'double'
cl <- read.table('times.txt', header = FALSE, colClasses=cl)
cl <- as.numeric(unlist(cl))

colorEgySzal<- "blue"
colorKetSzal <- "red"
colorNegySzal <- "green"
points(rows[1],cl[1],col="blue",pch=16)
points(rows[2],cl[2],col="blue",pch=16)
points(rows[3],cl[3],col="blue",pch=16)
text(rows[1],cl[1],labels=cl[1],pos=3,col=colorEgySzal)
text(rows[2],cl[2],labels=cl[2],pos=3,col=colorEgySzal)
text(rows[3],cl[3],labels=cl[3],pos=3,col=colorEgySzal)
#axis(side = 1, at = c(data1[1:3,3]))


#a többi vonal hozzáadása
lines(data1[4:6,3:2], type="l",col="blue")
lines(data1[7:9,3:2], type="l",col="green")

points(rows[1],cl[4],col="red",pch=16)
points(rows[2],cl[5],col="red",pch=16)
points(rows[3],cl[6],col="red",pch=16)

text(rows[1],cl[4],labels=cl[4],pos=3,col=colorKetSzal)
text(rows[2],cl[5],labels=cl[5],pos=3,col=colorKetSzal)
text(rows[3],cl[6],labels=cl[6],pos=3,col=colorKetSzal)

points(rows[1],cl[7],col="green",pch=16)
points(rows[2],cl[8],col="green",pch=16)
points(rows[3],cl[9],col="green",pch=16)

text(rows[1],cl[7],labels=cl[7],pos=1,col=colorNegySzal)
text(rows[2],cl[8],labels=cl[8],pos=1,col=colorNegySzal)
text(rows[3],cl[9],labels=cl[9],pos=1,col=colorNegySzal)

#jelmagyarázat
legend("topleft", c("1 szál","2 szál","4 szál"), fill=c("red","blue","green"))

dev.off()
