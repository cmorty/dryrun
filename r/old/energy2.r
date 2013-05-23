pdf("energy.pdf", width=5.5, height = 4)
par(mar=c(5,4,.5,1)+0.1)
ds=as.POSIXlt("2011-03-01")+0
de=as.POSIXlt("2011-03-01")+0

gs=as.POSIXlt("2010-11-01")+0
ge=as.POSIXlt("2011-02-01")+0

sd <- all[all$time < ds | all$time>de ,]
#gap.plot(sd$time, sd$mean+sd$sd, gap.axis="x", gap=c(ds+0,de+0), xlab="Date of Contiki revision", ylab="Average final energy consumption / mJ", ylim=c(0,max(sd$mean+sd$sd)+10), yaxs="i", type="n", xaxs="i", xlim=c(gs,ge))

plot(sd$time, sd$mean+sd$sd, gap.axis="x", xlab="Date of Contiki revision", ylab="Average final energy consumption / mJ", ylim=c(0,max(sd$mean+sd$sd)+10), yaxs="i", type="n", xaxs="i", xlim=c(gs,ge))
m <-  seq(gs, ge, by="month")
m <- data.frame( m)
m2 <- m[m$m < ds | m$m > de ,]
m3 <- m2[seq(1, length(m2), 2)]
mm <- m3[c(1:2,4:9)]

axis(1, at=m, labels=FALSE, tcl=-0.2)
axis(1, at=mm, labels=format(mm,"%b"), tcl=-0.3)



arrows(sd$time+0, sd$mean+sd$sd, sd$time+0, sd$mean-sd$sd, angle=90, code=3, length=.02, col="gray")

e <- sd[sd$last >= 599.5,]
points(e$time, e$mean, col="red")
#points(all$time, all$mean, col="red")

e <- sd[sd$last < 599.5 & sd$sd > 100,]
points(e$time, e$mean, col="blue", pch=2)

legend("topleft", legend=c("Failed tests", "Successfull tests") , pch=c(1,2), col=c("red","blue"))

dev.off()








save(all,file="data.Rda")
