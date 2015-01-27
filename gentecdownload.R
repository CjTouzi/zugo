
# fileware download

gentech.download <- function(filelist, catalog) {
    
    
    file  <- read.csv(file = filelist, sep="\t", skip=1, header=FALSE)
    
    names(file) <- c("name","description","version","size", "file.name")

    # prefix of the download link
        
    # most links prefix
     prefix <- paste("http:/", "gentec-eo.com","Content", "downloads", catalog, sep="/")
    
    # catalogues prefix
    
    # prefix <- paste("http:/", "gentec-eo.com","Content", "contact-us", catalog, sep="/")
    
    
    # download link list
    file$link <-  paste(prefix,file$file.name, sep="/")
    
    
    # create sub folder for this catalog
    dir.create(paste("./gentech", catalog, sep="/"), showWarnings = FALSE)
    
    destfile <- paste("./gentech", catalog, file$file.name, sep="/")
    
    # download 
    
    for (i in 1:length(destfile)){ 
        
        print(try (download.file(file$link[i],destfile = destfile[i], method="auto"), silent=TRUE))
        # print(paste("write file to ",normalizePath(destfile[i])))
    }
    
    
    # print a summary table in the gentech folder 
    
    write.table(file, paste0( paste("./gentech", catalog, sep="/"), ".csv"), sep="\t", row.names=FALSE, col.names=TRUE) 
    
    file
 
}



list <- list.files("./gentech/filelist/")
cata <- sub(".txt", "", list.files("./gentech/filelist/"))
list
list[[7]] <- NA
list[[3]] <- NA

for (i in 6 : 6){
    
    filelist <- paste("./gentech", "filelist", list[i], sep="/")
    
    gentech.download(filelist,cata[i])
    print(i)
    
}


