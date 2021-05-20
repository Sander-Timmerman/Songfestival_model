train_model <- function(gemiddelden_live) {
  gecombineerd_alles <- data.frame(Land = character(),
                                   Jury = numeric(),
                                   Televote = numeric(),
                                   Uitslag = numeric(),
                                   Bookmakers = numeric(),
                                   Youtube = numeric(),
                                   iTunes = numeric())
  for(year in 2018 : 2019) {
    gecombineerd <- combineer_data(year, gemiddelden_live, 4)
    gecombineerd <- voeg_uitslag_toe(gecombineerd, year)
    gecombineerd_alles <- rbind(gecombineerd_alles, gecombineerd)
  }
  
  model <- lm(Uitslag ~ Bookmakers + Youtube + iTunes, data = na.omit(gecombineerd_alles))
  return(model)
}
