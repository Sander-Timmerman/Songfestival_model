bereken_live_gemiddelden <- function() {
  youtube_all <- data.frame(Land = character(),
                            Streams = numeric(),
                            Halve_finale = numeric(),
                            Live = factor())
  for(year in c("2018", "2019", "2021")) {
    youtube <- read.csv(paste0("Data/youtube ", year, ".csv"))
    youtube_all <- rbind(youtube_all, youtube)
  }
  gemiddelden_live <- youtube_all %>%
    group_by(Live) %>%
    summarise(Gemiddelde_streams = mean(Streams, na.rm = TRUE)) %>%
    ungroup()
  return(gemiddelden_live)
}

