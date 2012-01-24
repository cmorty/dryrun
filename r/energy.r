library(plotrix)

energy <- function(q) {
  q$Time <- as.numeric(q$Time) / 1E6
  q$energy <- as.numeric(q$energy)

  timerange <- c(0, max(q$Time))

  t <- seq(min(timerange), max(timerange), length.out=2000)

  e = list()
  for(m in unique(q$mote)) {
    e[[m]] <- max(q$energy[q$mote==m])
  }

  e <- data.frame(e)

  emax <- max(e,1)
  emin <- min(e,20000)

  print(e)	
  print(emax)
  print(emin)
  means <- rowMeans(e)
  dev <- apply(e, 1, sd)

  return(list(mean=means[length(means)], dev=dev[length(dev)], last=max(q$Time), emax=emax, emin=emin))
}



pattern <- ".trace"
files <- dir(".", pattern)

times = list()
timestamps <-scan("times.data",sep=" ", what=list(hash="", time=0))
e = list(time=vector(), mean=vector(), sd=vector(), last=vector())
for(f in files) {
  print(f)
  q <- read.table(f, header=TRUE, sep="\t")

  h <- unlist(strsplit(f, "#"))[1]
  t <- timestamps$time[timestamps$hash==h]
  print(t)
  en <- energy(q)
  if(length(en$mean) > 0) {
    e$time <- append(e$time, t) 
    e$mean <- append(e$mean, en$mean)
    e$sd <- append(e$sd, en$dev)
    e$last <- append(e$last, en$last)
    e$max <- append(e$max, en$emax)
    e$min <- append(e$min, en$emin)
  }
}

e$time <- as.POSIXlt(as.numeric(e$time), origin="1970-01-01")
e$mean <- as.numeric(e$mean)
e$sd <- as.numeric(e$sd)

all <- data.frame(e)


pdf("energy.pdf", width=6.5, height = 3.8)
par(mar=c(4,4,.8,1)+0.1)
ds=as.POSIXlt("2011-03-01")+0
de=as.POSIXlt("2011-03-01")+0

gs=as.POSIXlt("2010-08-01")+0
ge=as.POSIXlt("2011-02-15")+0

#sd <- all[all$time < ds | all$time>de ,]
sd <- all
#gap.plot(sd$time, sd$mean+sd$sd, gap.axis="x", gap=c(ds+0,de+0), xlab="Date of Contiki revision", ylab="Average final energy consumption / mJ", ylim=c(0,max(sd$mean+sd$sd)+10), yaxs="i", type="n", xaxs="i", xlim=c(gs,ge))

plot(sd$time, sd$mean+sd$sd, xlab="Date of Contiki revision", ylab="Average final energy consumption / mJ", ylim=c(0,max(sd$max)+30), yaxs="i", type="n", xaxs="i", xlim=c(gs,ge), xaxt="n")
m <-  seq(gs, ge, by="month")
m <- data.frame( m)
m2 <- m[m$m < ds | m$m > de ,]

axis(1, at=m2, labels=format(m2,"%b-%y"), tcl=-0.3)



arrows(sd$time+0, sd$min, sd$time+0, sd$max, angle=90, code=3, length=.02, col="gray")

e <- sd[sd$last >= 599.5,]
points(e$time, e$mean, col="red")
#points(all$time, all$mean, col="red")

e <- sd[sd$last < 599.5 & sd$sd > 100,]
points(e$time, e$mean, col="blue", pch=2)

legend("topleft", legend=c("Failed tests", "Successfull tests") , pch=c(1,2), col=c("red","blue"))

dev.off()
