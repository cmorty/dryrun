# TODO: Add comment
# 
# Author: morty
###############################################################################


library(ggplot2)
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
	require(grid)
	
	# Make a list from the ... arguments and plotlist
	plots <- c(list(...), plotlist)
	
	numPlots = length(plots)
	
	# If layout is NULL, then use 'cols' to determine layout
	if (is.null(layout)) {
		# Make the panel
		# ncol: Number of columns of plots
		# nrow: Number of rows needed, calculated from # of cols
		layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
				ncol = cols, nrow = ceiling(numPlots/cols))
	}
	
	if (numPlots==1) {
		print(plots[[1]])
		
	} else {
		# Set up the page
		grid.newpage()
		pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
		
		# Make each plot, in the correct location
		for (i in 1:numPlots) {
			# Get the i,j matrix positions of the regions that contain this subplot
			matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
			
			print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
							layout.pos.col = matchidx$col))
		}
	}
}


t1 <- function() {

	dbc <- dbConnect("SQLite", cstr(".", "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, C_COLLECT_CONF_RECENT_PACKETS,  max(Data)  from energy where 
		C_WITH_PHASE_OPTIMIZATION = 1 AND C_NETSTACK_CONF_MAC_SEQNO_HISTORY=16 AND MOTE = 2 AND VAR = 'datarecv' GROUP BY C_COLLECT_CONF_RECENT_PACKETS, C_MAX_ACK_MAC_REXMITS ;")

	ggplot(ans, aes(x=C_COLLECT_CONF_RECENT_PACKETS, y=C_MAX_ACK_MAC_REXMITS, weight=`max(Data)`)) + geom_tile(aes(fill=`max(Data)`))

}

t2 <- function() {
	dbc <- dbConnect("SQLite", cstr(".", "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, C_COLLECT_CONF_RECENT_PACKETS,  max(Data), Mote  from energy where 
		C_WITH_PHASE_OPTIMIZATION = 0 AND C_NETSTACK_CONF_MAC_SEQNO_HISTORY=16 GROUP BY C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, C_COLLECT_CONF_RECENT_PACKETS, Mote ;")
	
	m <- getopt("energy")
	ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l <- match(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE,m$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE)
	p <- list()
	
	for(mm in 1:7) {
		p[[mm]] <- ggplot(ans[(ans$Mote == mm) & (ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l != 9), ], aes(x=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l, y=C_COLLECT_CONF_RECENT_PACKETS, weight=`max(Data)`)) + geom_tile(aes(fill=`max(Data)`)) + scale_fill_gradient2() 
	}
	multiplot(p[[1]],p[[2]],p[[3]],p[[4]],p[[5]], p[[6]], p[[7]], cols = 3)
} 


//Random
t3 <- function(file = ".") {
	dbc <- dbConnect("SQLite", cstr(file, "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, seed, Mote, max(Data)  from energy  
					GROUP BY C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE, seed, Mote ;")
	
	m <- getopt("energy")
	ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l <- match(ans$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE,m$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE)
	
	
	ggplot(ans[ans$`max(Data)` < 50000 , ], aes(factor(C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE), `max(Data)`)) + geom_violin()  + facet_wrap(~ Mote) # + geom_jitter()
	
}




