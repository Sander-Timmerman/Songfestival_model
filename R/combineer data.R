combineer_data <- function(year, gemiddelden_live, n) {
  bookmakers <- read.csv(paste0("Data/bookmakers ", year, ".csv"), dec = ",")
  youtube <- get_youtube_streams(year, gemiddelden_live) %>%
    filter(Land %in% bookmakers$Land)
  itunes <- get_itunes_numbers(year, n)
  gecombineerd <- data.frame(Land = bookmakers$Land,
                             Bookmakers = bookmakers$Odds ^ 0.1,
                             Youtube = youtube$Streams_genormaliseerd,
                             iTunes = itunes$Totaal_gemiddeld ^ 0.1) %>%
    mutate(Bookmakers = Bookmakers / mean(Bookmakers),
           Youtube = Youtube / mean(Youtube, na.rm = TRUE),
           iTunes = iTunes / mean(iTunes))
  return(gecombineerd)
}

