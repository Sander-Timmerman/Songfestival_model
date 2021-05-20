library(dplyr)
library(mgsub)
library(xlsx)
source("R/youtube live gemiddelde.R")
source("R/youtube.R")
source("R/itunes.R")
source("R/combineer data.R")
source("R/train_model.R")
source("R/uitslag.R")

gemiddelden_live <- bereken_live_gemiddelden()
model <- train_model(gemiddelden_live)
print(summary(model))

# nieuwe_data <- combineer_data("2021", 1)
# voorspelling <- data.frame(Land = nieuwe_data$Land,
#                            Bookmakers = rank(nieuwe_data$Bookmakers, ties.method = "min"),
#                            YouTube = nrow(nieuwe_data) - rank(nieuwe_data$Youtube, ties.method = "max"),
#                            iTunes = nrow(nieuwe_data) - rank(nieuwe_data$iTunes, ties.method = "max"),
#                            Punten = predict(model, nieuwe_data))
# write.xlsx(voorspelling, file = "Output/voorspelling.xlsx")