library(RSQLite)



cstr <- function(...){return(paste(..., sep=''))}


gettbls <- function(folder = '.'){
	dbc <- dbConnect("SQLite", cstr(folder, "/results.sqlite"))
	tbls <- dbListTables(dbc)
	return(tbls[tbls != "DRYRUN"])
}

getconf <- function(folder = '.'){
	dbc <- dbConnect("SQLite", cstr(folder, "/results.sqlite"))
	ans <- dbGetQuery(dbc, "select value from dryrun where key = 'conf'")
	return(ans$value)
}


getopt <- function(table, folder = '.'){
	dbc <- dbConnect("SQLite", cstr(folder, "/results.sqlite"))
	cnfs <- getconf(folder)
	rv <- list();
	for(cnf in cnfs	){
		ans <- dbGetQuery(dbc, cstr("select distinct ", cnf, " from ",  table))
		ans <- ans[[cnf]]
		ans <- c(ans)
		ans <- sort(ans)
		rv[[cnf]] <- ans;
	}
	return(rv)
}

getvar <- function(folder = '.'){
	dbc <- dbConnect("SQLite", cstr(folder, "/results.sqlite"))
	tbls = gettbls(folder)
	rv <- list();
	for(tbl in tbls	){
		ans <- dbGetQuery(dbc, cstr("select distinct VAR from ",  tbl , " ORDER BY VAR"))
		rv[[tbl]] <- ans;
	}
	return(rv)
}