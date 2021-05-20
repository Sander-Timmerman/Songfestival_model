voeg_uitslag_toe <- function(gecombineerd, year) {
  uitslag <- read.csv(paste0("Data/uitslag ", year, ".csv"))
  gecombineerd <- gecombineerd %>% mutate(Jury = uitslag$Jury,
                                          Televote = uitslag$Televote,
                                          Uitslag = uitslag$Jury + uitslag$Televote)
  return(gecombineerd)
}