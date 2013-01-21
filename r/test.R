reshape = importr('reshape')
dataf = reshape.melt(volcano)
dataf = dataf.cbind(ct = lattice.equal_count(dataf.rx2("value"), number=3, overlap=1/4))



wireframe(bias ~ a * phi,
		 data = ols, screen =
		 list(z = -245, x = -75),
		 xlab = expression(paste(alpha)),
		 ylab = expression(paste(phi)),
		 zlab = "Bias",
		 zlim = range(seq(0.0, 0.85, by=0.20)))
 
 pp <- function (n,r=4) {
	 x <- seq(-r*pi, r*pi, len=n)
	 df <- expand.grid(x=x, y=x)
	 df$r <- sqrt(df$x^2 + df$y^2)
	 df$z <- cos(df$r^2)*exp(-df$r/6)
	 df
 }
 qplot(x, y, data = pp(20), fill = z, geom = "raster")
 
 p <- list()
 
 for(mm in 1:7) {
	 p[[mm]] <- ggplot(ans3[(ans3$Mote == mm) & (ans3$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l != 9), ], aes(x=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l, y=C_COLLECT_CONF_RECENT_PACKETS, weight=`max(Data)`)) + geom_tile(aes(fill=`max(Data)`)) + scale_fill_gradient2(limits = c(-807, 5700), low="red")
 }
 multiplot(p[[1]],p[[2]],p[[3]],p[[4]],p[[5]], p[[6]], p[[7]], cols = 3)
 
 
 for(mm in 1:7) {
	 p[[mm]] <- ggplot(ans[(ans2$Mote == mm) & (ans2$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l %in% c(3,4)) , ], aes(x=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l, y=C_COLLECT_CONF_RECENT_PACKETS, weight=`max(Data)`)) + geom_tile(aes(fill=`max(Data)`)) + scale_fill_gradient2() 
 }
 multiplot(p[[1]],p[[2]],p[[3]],p[[4]],p[[5]], p[[6]], p[[7]], cols = 3)
 
 l2 <- ans2[ans2$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l %in% c(2),]
 l3 <- ans2[ans2$C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l %in% c(3),]
 
 ldiff <- l2
 ldiff$`max(Data)` <- l2$`max(Data)` - l3$`max(Data)`
 
 for(mm in 1:7) {
	 p[[mm]] <- ggplot(ldiff[(ldiff$Mote == mm)  , ], aes(x=C_NETSTACK_CONF_RDC_CHANNEL_CHECK_RATE_l, y=C_COLLECT_CONF_RECENT_PACKETS, weight=`max(Data)`)) + geom_tile(aes(fill=`max(Data)`)) + scale_fill_gradient2() 
 }
 multiplot(p[[1]],p[[2]],p[[3]],p[[4]],p[[5]], p[[6]], p[[7]], cols = 3)
 