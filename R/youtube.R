get_youtube_streams <- function(year, gemiddelden_live) {
  youtube <- read.csv(paste0("Data/youtube ", year, ".csv"))
  gemiddelden_halve_finales <- youtube %>%
    group_by(Halve_finale) %>%
    summarise(Gemiddelde_streams = mean(Streams, na.rm = TRUE)) %>%
    ungroup()
  
  youtube <- youtube %>%
    mutate(Streams_genormaliseerd = Streams / 
             as.numeric(mgsub(youtube$Halve_finale,
                              gemiddelden_halve_finales$Halve_finale,
                              gemiddelden_halve_finales$Gemiddelde_streams)) /
             as.numeric(mgsub(as.character(youtube$Live),
                              gemiddelden_live$Live,
                              gemiddelden_live$Gemiddelde_streams)) *
             mean(youtube$Streams, na.rm = TRUE) ^ 2
    ) %>%
    select(Land, Streams_genormaliseerd)
  return(youtube)
}
