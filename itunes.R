get_itunes_numbers <- function(year, n) {
  itunes_gemiddeld <- data.frame(Land = read.csv(paste0("Data/itunes ", year, " 1.csv"))$Land)
  for(i in 1 : n) {
    itunes <- read.csv(paste0("Data/itunes ", year, " ", i, ".csv"))
    for(column_nr in seq_len(ncol(itunes))[-1]) {
      itunes[which(itunes$Land %in% gsub(".", " ", colnames(itunes)[column_nr], fixed = TRUE)), column_nr] <- 0
      column <- itunes[column_nr]
      nas_in_column <- is.na(column)
      itunes[nas_in_column, column_nr] <- (58 - ifelse(all(nas_in_column),
                                                       0,
                                                       sum(column, na.rm = TRUE))) / sum(nas_in_column)
    }
    itunes_gemiddeld[i + 1] <- rowSums(itunes[-1])
  }
  itunes_gemiddeld <- itunes_gemiddeld %>%
    mutate(Totaal_gemiddeld = rowMeans(itunes_gemiddeld[-1])) %>%
    select(Land, Totaal_gemiddeld)
  return(itunes_gemiddeld)
}
