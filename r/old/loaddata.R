# TODO: Add comment
# 
# Author: morty
###############################################################################
library(RSQLite)

cstr <- function(...){return(paste(..., sep=''))}



loadExperiment <- function(folder) {
	rv = list()
	resfolder <- cstr(folder, "/",  "results")
	print(folder)
	print(resfolder)
	rv$settings <- read.table(cstr(folder, "/conf.txt"), sep ="=", col.names = c("key", "val"))
	log <- readLines(cstr(resfolder,  "/COOJA.log"))
	simdata <- log[grepl("loop stopped", log )]
	# R sucks!!!
	simdata<-strsplit(gsub(".*\\[(\\d+:\\d+:\\d+).*time: (\\d*).*n: (\\d*).*e (\\d*).*io (\\d*.\\d*).*", "\\1,\\2,\\3,\\4,\\5", simdata, perl=TRUE),",")
	rv$sim["endtime"] <- as.real(simdata[[1]][2])
	rv$sim["duration"] <-as.real(simdata[[1]][3])
	rv$sim["simtime"] <- as.real(simdata[[1]][4])
	dbs <- dir(resfolder, "*.db")
	
	rv$data <- list()
	for(db in dbs){
		dbc <- dbConnect("SQLite", cstr(resfolder, "/", db))
		tbls <- dbListTables(dbc)
		if(length(tbls) != 0){
			rv$data[[db]] = list()
			for(tbl in tbls){
				ans <- dbGetQuery(dbc, paste("select * from", tbl))
				
				if(length(tbls) == 1) {
					rv$data[[db]] <- ans				
				} else {
					rv$data[[db]][[tbl]]
				}
			
			}
		}
		
	}
		
	
	return(rv)
} 



loadExperiments <- function(folder){
	rv = list();
	folders <- dir(folder, "*")
	folders <- subset(folders, 1 != ".")
	folders <- cstr(folder, "/", folders)
	folders <- folders[file.info(folders)$isdir]
	
	for(f in folders){
		
		rv[[f]] <- loadExperiment(f)
		
	}
	return (rv)
}


