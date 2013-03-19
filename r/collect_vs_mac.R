# TODO: Add comment
# 
# Author: morty
###############################################################################



# TODO: Add comment
# 
# Author: morty
###############################################################################
library(ggplot2)
source('/proj/i4work/morty/dryrun/r/dryrun_db.R')

# setwd('/proj/i4labs/morty/experiments/test_collect')
setwd('/tmp/morty/')

d1 <- new.env()

d1$tab <- 'ser'


conf <- new.env()
conf$field <- getconf(d1)
conf$field <- conf$field[conf$field != "seed"]
conf$data <- c('Data')
conf$cond <- ""
conf$filt = c("coll.qdrop", "coll.ttldrop", "eqdrop", "rcv_lost" )
#conf$cond <- " where C_QUEUEBUF_CONF_NUM in (1,2,4,8) AND C_COLLECT_CONF_RECENT_PACKETS==4 and C_WITH_PHASE_OPTIMIZATION==1 and C_COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS IN (1,2,3)"
		

getdata <- function(db, conf) {
	
	fld <- paste(conf$field,collapse=", ")
	
	ans <- dbGetQuery(db$dbc, cstr("select VAR, ", fld, ", seed, Mote,  Data, success, hash  from ", db$tab , " " , conf$cond ," ;"))
	
	ffor <- function(l){
		if(l > 10 ) return(as.character(l)) 
		else return(paste("0", as.character(l),sep=""))
	}
	fcon <- function(p){return(paste(lapply(p, ffor), collapse='_'))}
	
	if(length(conf$filed) > 1){
		ans$attr <- apply(ans[,conf$field],1, fcon)
	} else {
		ans$attr <- sapply(ans[,conf$field], ffor)
	}
	return(dfopt(ans, conf$data))
}

bla <- function(){	
	ans$f_label = factor(ans$C_DATA_SND_RATE)
	
	levels(ans$f_label) <- cstr("Paket alle: ", levels(ans$f_label), "s")
	
	
	mote <- 1
	ggplot(ans[ans$Mote==mote & ans$success==1 ,], aes(x=`Data`, group = factor(attr),  colour=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE )) + 
			guides(colour = guide_legend(title="Channel \nCheck\n Rate ")) + geom_density() + facet_wrap(~ f_label, scales="free_x")	+
			labs(x = "Energieeinheiten", y="Dichte", title=cstr("Knoten " ,as.character(mote)))
	
	ggsave(file=cstr("Energie_K" ,as.character(mote),".pdf"))
}




filt <- function(d, conf){
#	flt <- c("ener.CPU", "ener.LPM", "ener.TRANSMIT", "ener.LISTEN")
#	flt <- c("rime.contentiondrop", "rime.badsynch", "rime.rx", "rime.llrx")
#	flt <- c("ener.CPU", "ener.LPM", "ener.TRANSMIT", "ener.LISTEN", "rime.contentiondrop")
#	flt <- c("ener.CPU", "ener.LPM", "ener.TRANSMIT", "ener.LISTEN", "rime.contentiondrop","coll.duprecv",
#			"coll.qdrop", "coll.ttldrop" )
	#flt <- c("coll.qdrop", "coll.ttldrop", "eqdrop", "rcv_lost" )
	
	#d <- d[d$C_QUEUEBUF_CONF_NUM != "32",]
	dt <- d[d$VAR %in% conf$flt, ]
	#return(dt)			
	return(dfopt(dt, conf$data))
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



#Failes
showfail <- function(m){
	for(val in conf$field){
		X11(type = "dbcairo")
		t <- ggplot(m, aes(m[[val]], `success`, colour=m[[val]])) +  geom_bar() 
		print(t)
	}
}


failstats <- function(m){
	table(factor((m[m$success == "0",])$attr))
}


varstats <- function(m, conf){
	for(v in  levels(m$VAR)){
		print(v)
		print(summary((m[m$VAR == v,])[[conf$data]]))
	}
} 


failhash <- function(m, conf){
	t <- m[m$success == "0" & m$C_QUEUEBUF_CONF_NUM != "32",]
	t <- dfopt(t, conf$data)
	return(t$hash)
}


#dev.set(2)
#plt(z1)
#dev.set(3)
#plt(z2)


multiplot <- function(m) {
	
	cdev <- 2
	m$attr <- factor(m$attr, sort(levels(m$attr)))
	for(val in levels(m$VAR)){
		print(val)
		#dev.set(cdev) #New dev
		X11(type = "dbcairo")
		cdev <- cdev +1
		print("b")
		t <- ggplot(m[m$VAR==val,], aes(attr, `Data`, colour=attr)) + geom_boxplot() +# geom_jitter()   +  
				facet_wrap(~ Mote,  nrow = 1) + labs( title=val, y = val) 
		print(t)
	}
	
}

d1$dbc <- dbConnect("SQLite", cstr("queuebuf", "/results.sqlite"))
f1 <- getdata(d1,conf)



conf$filt = c("coll.qdrop", "coll.ttldrop", "eqdrop", "rcv_lost" )
z1 <- filt(f1, conf)



multiplot(z1)


exp <- getexp(d1, conf)

#vs mac


	
z2 <- z1[		#z1$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE == "8" &		  
			#z1$C_COLLECT_CONF_RECENT_PACKETS == "16" &
				z1$C_COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS == "3" 
				#z1$C_WITH_PHASE_OPTIMIZATION == "1" &
				#z1$C_QUEUEBUF_CONF_NUM == "8"				
				,]

z2 <- dfopt(z2, conf$data)
multiplot(z2)


