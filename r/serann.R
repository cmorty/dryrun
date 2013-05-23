# TODO: Add comment
# 
# Author: morty
###############################################################################
library(ggplot2)
source('/proj/i4work/morty/dryrun/r/dryrun_db.R')
setwd('/proj/i4labs/morty/experiments/test_collect')

d1 <- new.env()
d1$dbc <- dbConnect("SQLite", cstr("exp_tb_rand", "/results.sqlite"))
d1$tab <- 'ser'

d2 <- new.env()
d2$dbc <- dbConnect("SQLite", cstr("tb_rand", "/results.sqlite"))
d2$tab <- 'exp0_000'

conf <- new.env()
conf$field <- getconf(d1)
conf$field <- conf$field[conf$field != "seed"]
conf$data <- c('Data')
conf$filt <- c("ener.CPU", "ener.LPM", "ener.TRANSMIT", "ener.LISTEN")
#	flt <- c("rime.contentiondrop", "rime.badsynch", "rime.rx", "rime.llrx")


f1 <- getdata(d1,conf)
f2 <- getdata(d2,conf)

filt <- function(d, conf){

	dt <- d[d$VAR %in% conf$filt, ]
	return(dt)			
	#return(dfopt(dt, conf$data))
}

plt_dens_var <- function(dt){
	ggplot(dt, aes(x=`Data`,group = factor(attr),  colour=factor(C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE) )) +  geom_density()  +  facet_wrap(~ VAR, scales="free")
}

plt_box_var <- function(dt){
	ggplot(dt, aes(attr, `Data`, colour=attr )) +  geom_boxplot()  +  facet_wrap(~ VAR, scales="free")
}

plt_dens_mote <- function(dt){
	ggplot(dt, aes(x=`Data`,group = factor(attr),  colour=factor(C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE) )) +  geom_density()  +  facet_wrap(~ Mote, scales="free")
}

plt_box_mote <- function(dt){
	ggplot(dt, aes(attr, `Data`, colour=attr )) +  geom_boxplot()  +  facet_wrap(~ Mote, scales="free")
}



tmerge <- function(r, s){
	levels(r$attr) <- cstr(levels(r$attr), "_mes")
	levels(s$attr) <- cstr(levels(s$attr), "_sim")	
	w <- rbind(r, s)
#	w$attr <- factor(w$attr, levels = c("8_mes","8_sim", "16_mes","16_sim", "32_mes","32_sim"))
	return(w)	
} 


z1 <- filt(f1, conf)
z2 <- filt(f2, conf)

w <- tmerge(z2, z1)



#dev.set(2)
#plt(z1)
#dev.set(3)
#plt(z2)


multiplot <- function(m) {

	cdev <- 2
	for(val in levels(m$VAR)){
		print(val)
		#dev.set(cdev) #New dev
		X11(type = "dbcairo")
		cdev <- cdev +1
		print("b")
		t <- ggplot(m[m$VAR==val,], aes(attr, `Data`, colour=attr)) +  geom_boxplot()  +  
				facet_wrap(~ Mote,  nrow = 1) + labs( title=val, y = val) 
		print(t)
	}

}


multiplot(w)

