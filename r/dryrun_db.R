library(RSQLite)



cstr <- function(...){return(paste(..., sep=''))}


gettbls <- function(db){
	tbls <- dbListTables(db$dbc)
	return(tbls[tbls != "DRYRUN" & substr(tbls,1,1) != "_"])
}

getconf <- function(db){
	ans <- dbGetQuery(db$dbc, "select value from dryrun where key = 'conf'")
	return(ans$value)
}


getopt <- function(table, db){
	cnfs <- getconf(db)
	rv <- list();
	for(cnf in cnfs	){
		ans <- dbGetQuery(db$dbc, cstr("select distinct ", cnf, " from ",  table))
		ans <- ans[[cnf]]
		ans <- c(ans)
		ans <- sort(ans)
		rv[[cnf]] <- ans;
	}
	return(rv)
}

getdata <- function(db, conf) {
	
	fld <- paste(conf$field,collapse=", ")
	
	ans <- dbGetQuery(db$dbc, cstr("select VAR, ", fld, ", seed, Mote, max(Data) as Data, success  from ", db$tab , "  
							GROUP BY Var, ",fld , ", seed, Mote ;"))
	
	fcon <- function(...){return(paste(..., sep='_'))}
	if(length(conf$filed) > 1){
		ans$attr <- apply(ans[,conf$field],1, fcon)
	} else {
		ans$attr <- sapply(ans[,conf$field], ffor)
	}
	
	return(dfopt(ans, conf$data))
}

getexp <- function(db, conf){
	fld <- paste(conf$field,collapse=", ")
	ans <- dbGetQuery(db$dbc, "select * from _experiment")
	fcon <- function(...){return(paste(..., sep='_'))}
	if(length(conf$filed) > 1){
		ans$attr <- apply(ans[,conf$field],1, fcon)
	} else {
		ans$attr <- sapply(ans[,conf$field], ffor)
	}
	return(dfopt(ans, conf$data))
	
}

getvar <- function(db){
	tbls = gettbls(db)
	rv <- list();
	for(tbl in tbls	){
		ans <- dbGetQuery(db$dbc, cstr("select distinct VAR from ",  tbl , " ORDER BY VAR"))
		rv[[tbl]] <- ans;
	}
	return(rv)
}

dfopt <- function(d,exc=c()){
	for(name in names(d)){
		if(! (name %in% exc)){
			#print(name)
			d[[name]] = factor(d[[name]])
		}
	}
	return(data.frame(d))
}
