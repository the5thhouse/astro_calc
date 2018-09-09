import swisseph as swe
import datetime
swe.set_ephe_path('/home/delores/ephemeris/') # set path to ephemeris files
import pandas as pd
from pandas import DataFrame as df
import sys

#for a date, time and location, find the positions of all planets and houses


#natal_year = 2018
#natal_month = 7
#natal_day = 10
#natal_hour_dec = 8.933333
#natal_lat = 39.95
#natal_lon = -75.3
#natal_filename = 'angela'

natal_year = int(sys.argv[1])
natal_month = int(sys.argv[2])
natal_day = int(sys.argv[3])
natal_hour_dec = float(sys.argv[4])
natal_lat = float(sys.argv[5])
natal_lon = float(sys.argv[6])
natal_filename = sys.argv[7]

print('assigned sys args ', sys.argv[7])

planets = list(range(0,11)) + [15, 17, 18, 19, 20, 16]
#house_cusps0 = swe.houses(swe.julday(natal_year, natal_month, natal_day, natal_hour_dec), natal_lat, natal_lon, hsys='K'.encode('ascii'))[0]
house_cusps0 = swe.houses(swe.julday(natal_year, natal_month, natal_day, natal_hour_dec), natal_lat, natal_lon)[0]
planet_positions = df([swe.get_planet_name(p), swe.calc_ut(swe.julday(natal_year, natal_month, natal_day, natal_hour_dec), p)[0]] for p in planets)
house_nums = range(12)
house_cusps = df(['house' + str(p+1), house_cusps0[p]] for p in house_nums)
asteroids = range(10005, 10020)
asteroid_positions = df([p, swe.calc_ut(swe.julday(natal_year, natal_month, natal_day, natal_hour_dec), p)[0]] for p in asteroids)
planet_positions = planet_positions.append(asteroid_positions)
planet_positions = planet_positions.append(house_cusps)

full_file = natal_filename + '.csv'
planet_positions.to_csv(full_file)




