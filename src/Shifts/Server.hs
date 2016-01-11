{-# LANGUAGE OverloadedStrings #-}
module Shifts.Server (runServer) where

import Control.Monad (filterM, liftM)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Either
import Data.List (sort)
import Data.Text hiding (filter)
import Data.Time.Calendar
import Data.Time.Clock (getCurrentTime, utctDay)
import Network.Wai
import Network.Wai.Handler.Warp
import Seeds as Seeds
import Servant
import Shifts.API as API
import Shifts.Types

type Handler a = EitherT ServantErr IO a

server :: Server ShiftsAPI
server =
       currentRoid
  :<|> showRoid
  :<|> listShifts

currentRoid :: Maybe Text -> Handler Eng
currentRoid inDuration = return $ Prelude.head Seeds.engineers

showRoid :: Text -> Handler Eng
showRoid initials = return $ Prelude.head Seeds.engineers

listShifts :: Maybe Text -> Handler [Shift]
listShifts startingAfter =
  case startingAfter of
    Nothing          -> return Seeds.shifts
    Just startString -> return $ filteredShifts startString

filteredShifts :: Text -> [Shift]
filteredShifts start = do
  parsedDay <- parseDurationString start
  filter (\s -> (_startDay s) > parsedDay) Seeds.shifts

currentDay :: IO Day
currentDay = liftM utctDay getCurrentTime

parseDurationString :: Text -> IO Day
parseDurationString duration =
  case duration of
    "7d" -> liftM (addDays 7) currentDay
    _    -> liftM (addDays 0) currentDay

app :: Application
app = serve API.shiftsAPI server

runServer :: Port -> IO ()
runServer port = run port app
