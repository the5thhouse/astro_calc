Sys.setenv(PATH = paste("/usr/bin/python3", Sys.getenv("PATH"),sep=":"))
library(data.table)
library(lubridate)
library(ggmap)
register_google(key = "AIzaSyB-bX5c1JDegE-as5dLg228-q4yVwz3HFM")

dec2deg <- function(decimal.degree, zodiac) {
  degree <- floor(decimal.degree)
  tmp <- (decimal.degree - degree) * 60
  minute <- floor(tmp)
  second <- round((tmp - floor(tmp))*60)
  
  return(paste0(degree, " ", substr(zodiac, 1, 3), " ", minute, "'", second, '"'))
}

#define the zodiac names and angle ranges
order.zodiac  <- data.table(zodiac = c("aries", "taurus", "gemini", "cancer", "leo", "virgo",
                                       "libra", "scorpio", "sagittarius", "capricorn", "aquarius",
                                       "pisces"),
                            lower_limit = seq(0, 330, 30),
                            upper_limit = c(seq(30-0.00001, 330, 30), 360))
