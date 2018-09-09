Sys.setenv(PATH = paste("/usr/bin/python3", Sys.getenv("PATH"),sep=":"))

library(data.table)
library(lubridate)

dec2deg <- function(decimal.degree, zodiac) {
  degree <- floor(decimal.degree)
  tmp <- (decimal.degree - degree) * 60
  minute <- floor(tmp)
  second <- round((tmp - floor(tmp))*60)
  
  return(paste0(degree, " ", substr(zodiac, 1, 3), " ", minute, "'", second, '"'))
}


#birth date in eastern time:
this.bday.est <- ymd_hms("1981-11-26 06:30:00", tz = "America/New_York")
this.bday.ut <- with_tz(this.bday.est, tzone = "UTC")

#load up the natal chart data from python
natal_filename = "rachael"
natal_year = year(this.bday.ut)
natal_month = month(this.bday.ut)
natal_day = day(this.bday.ut)
natal_hour_dec = hour(this.bday.ut) + minute(this.bday.ut)/60
natal_lat = 40.51
natal_lon = -74.85

#we'll call a python script from command line which will
#save a csv with the data that we need
#then we'll read that csv
py.command <- paste("python3 /home/delores/astro_calc/shiny/natal_table/get_natal.py", natal_year, natal_month, natal_day, natal_hour_dec, 
      natal_lat, natal_lon, natal_filename)
system(py.command)

this.natal <- fread(paste0(natal_filename, ".csv"))

#little cleaning
this.natal$V1 <- NULL
setnames(this.natal, c("object", "angle"))
this.natal <- this.natal[object != "0"]
this.natal <- this.natal[object != "Earth"]
#save the original order
this.natal[, object_order := 1:nrow(this.natal)]

asteroid.names <- data.table(read.csv("/home/delores/ephemeris/seasnam.txt", header = FALSE, nrows = 30, stringsAsFactors = FALSE))
asteroid.names[, object := as.character(as.numeric(substr(V1, 1, 6)) + 10000)]
asteroid.names[, object_name := substr(V1, 9, nchar(V1))]
asteroid.names[, V1 := NULL]

this.natal <- merge(this.natal,
                    asteroid.names,
                    by = "object", all.x = T, all.y = F)

this.natal[!is.na(object_name), object := object_name]
this.natal[, object_name := NULL]

#define the zodiac names and angle ranges
order.zodiac  <- data.table(zodiac = c("aries", "taurus", "gemini", "cancer", "leo", "virgo",
                                       "libra", "scorpio", "sagittarius", "capricorn", "aquarius",
                                       "pisces"),
                            lower_limit = seq(0, 330, 30),
                            upper_limit = c(seq(30-0.00001, 330, 30), 360))

#determine the zodiac
this.natal[, sign_number := as.integer(ceiling(angle / 30))]
this.natal[, sign := order.zodiac$zodiac[as.integer(ceiling(angle / 30))]]
this.natal[, deg_decimal := angle - (sign_number-1) * 30]
this.natal[, deg_percent := paste0(round(deg_decimal / 30 * 100), "%")]
this.natal[, deg_min_sec := dec2deg(deg_decimal, sign)]

#reformat angle and deg_decimal
this.natal[, angle := round(angle, 2)]
this.natal[, deg_decimal := round(deg_decimal, 2)]

setorder(this.natal, object_order)
View(this.natal)


this.natal[, object_order := NULL]
this.natal[, sign_number := NULL]
this.natal[, deg_percent := NULL]

setcolorder(this.natal, c("object", "sign", "deg_decimal", "deg_min_sec", "angle"))
output <- list()

write.csv(this.natal, file = "mynatal.csv", row.names = F)




