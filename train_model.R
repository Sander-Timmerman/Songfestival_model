library(dplyr)
library(mgsub)
source("youtube live gemiddelde.R")
source("youtube.R")
source("itunes.R")
gemiddelden_live <- bereken_live_gemiddelden()
gecombineerd_alles <- data.frame(Land = character(),
                                 Jury = numeric(),
                                 Televote = numeric(),
                                 Uitslag = numeric(),
                                 Bookmakers = numeric(),
                                 Youtube = numeric(),
                                 iTunes = numeric())
for(year in 2018 : 2019) {
  bookmakers <- read.csv(paste0("Data/bookmakers ", year, ".csv"), dec = ",")
  youtube <- get_youtube_streams(year, gemiddelden_live) %>%
    filter(Land %in% bookmakers$Land)
  itunes <- get_itunes_numbers(year, 4)
  uitslag <- read.csv(paste0("Data/uitslag ", year, ".csv"))
  gecombineerd <- data.frame(Land = bookmakers$Land,
                             Jury = uitslag$Jury,
                             Televote = uitslag$Televote,
                             Uitslag = uitslag$Jury + uitslag$Televote,
                             Bookmakers = bookmakers$Odds ^ 0.2,
                             Youtube = youtube$Streams_genormaliseerd ^ 0.5,
                             iTunes = itunes$Totaal_gemiddeld ^ 0.1) %>%
    mutate(Bookmakers = Bookmakers / mean(Bookmakers),
           Youtube = Youtube / mean(Youtube, na.rm = TRUE),
           iTunes = iTunes / mean(iTunes))
  gecombineerd_alles <- rbind(gecombineerd_alles, gecombineerd)
}

model <- lm(Uitslag ~ Bookmakers + Youtube + iTunes, data = na.omit(gecombineerd_alles))