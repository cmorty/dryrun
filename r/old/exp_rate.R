setwd('/proj/i4labs/morty/test_collect/exp_rate')
library(ggplot2)


t3 <- function() {
	dbc <- dbConnect("SQLite", cstr(".", "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, C_DATA_SND_RATE, seed, Mote, max(Data), success  from energy  
					GROUP BY C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, seed, Mote, C_DATA_SND_RATE ;")
	
	ans$attr=cstr(as.character(ans$C_DATA_SND_RATE), "_", as.character(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE))
	
	ans$C_DATA_SND_RATE = factor(ans$C_DATA_SND_RATE)
	ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE = factor(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE)
	
	
	ans$f_label = factor(ans$C_DATA_SND_RATE)
	
	levels(ans$f_label) <- cstr("Paket alle: ", levels(ans$f_label), "s")
	
	
	mote <- 1
	ggplot(ans[ans$Mote==mote & ans$success==1 ,], aes(x=`max(Data)`, group = factor(attr),  colour=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE )) + 
			guides(colour = guide_legend(title="Channel \nCheck\n Rate ")) + geom_density() + facet_wrap(~ f_label, scales="free_x")	+
			labs(x = "Energieeinheiten", y="Dichte", title=cstr("Knoten " ,as.character(mote)))
	
	ggsave(file=cstr("Energie_K" ,as.character(mote),".pdf"))
}



t4 <- function() {
	dbc <- dbConnect("SQLite", cstr(".", "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, C_DATA_SND_RATE, seed, Mote, max(Data), success  from collect
					WHERE var = 'timedout'   
					GROUP BY C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, seed, Mote, C_DATA_SND_RATE  ;")
	
	ans$attr=cstr(as.character(ans$C_DATA_SND_RATE), "_", as.character(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE))
	
	ans$C_DATA_SND_RATE = factor(ans$C_DATA_SND_RATE)
	ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE = factor(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE)
	
	
	ans$f_label = factor(ans$C_DATA_SND_RATE)
	
	levels(ans$f_label) <- cstr("Paket alle: ", levels(ans$f_label), "s")
	mote <- 1
	ggplot(ans[ans$Mote==mote & ans$success == 1,], aes(x=`max(Data)`, group = factor(attr),  colour=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE )) +  
			guides(colour = guide_legend(title="Channel \nCheck\nRate")) + geom_density() + facet_wrap(~ f_label)  +
		labs(x = "Verlorene Pakete", y="Dichte", title=cstr("Knoten " ,as.character(mote)))
	ggsave(file=cstr("Paketverlust_K" ,as.character(mote),".pdf"))
       
}

x = "Verlorene Pakete", y="Dichte", title=cstr("Knoten " ,as.character(mote))



dd <- data.frame(gp = factor(rep(1:5, each = 100)), y = rnorm(500))
ggplot(dd, aes(x = y, fill = gp, colour = gp)) +
		theme_bw() +
		geom_density(alpha = 0.3) +
		guides(fill=guide_legend(set.aes=list(colour=NULL, title="foo", alpha=0)))



dd <- data.frame(gp = factor(rep(1:5, each = 100)), y = rnorm(500))
ggplot(dd, aes(x = y, fill = gp, colour = gp)) +
		theme_bw() +
		geom_density(alpha = 0.3)  




df <- melt(outer(1:4, 1:4), varnames = c("X1", "X2"))

p1 <- ggplot(df, aes(X1, X2)) + geom_tile(aes(fill = value))
p2 <- p1 + geom_point(aes(size = value))
