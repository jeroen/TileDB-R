#!/usr/bin/Rscript

## by default we download the source from a given release
url <- "https://github.com/TileDB-Inc/TileDB/archive/2.0.8.tar.gz"

cat("Downloading ", url, "\n")
download.file(url, "tiledb.tar.gz", quiet=TRUE)
