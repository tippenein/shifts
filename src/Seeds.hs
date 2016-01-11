{-# LANGUAGE OverloadedStrings #-}
module Seeds (shifts, engineers) where

import Data.List (sort)
import Data.Time (Day, addDays, fromGregorian)
import Shifts.Types


bmo = Eng "bmo"
cgj = Eng "cgj"
ash = Eng "ash"

before = fromGregorian 2015 10 8
start = fromGregorian 2015 11 9
end = fromGregorian 2015 12 7

engineers = [bmo, cgj, ash]

shifts :: [ Shift ]
shifts = sort [
   Shift before start ash
 , Shift start end bmo
 , Shift end (addDays 14 end) bmo
 , Shift (fromGregorian 2014 2 2) (fromGregorian 2014 2 14) cgj]
