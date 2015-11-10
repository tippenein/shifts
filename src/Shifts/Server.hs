{-# LANGUAGE OverloadedStrings #-}
module Shifts.Server (runServer) where

import Control.Monad.Trans.Either
import Data.Text hiding (filter)
import Data.Time.Calendar
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Shifts.API as API
import Shifts.Types

type Handler a = EitherT ServantErr IO a

server :: Server ShiftsAPI
server =
       currentRoid
  :<|> showRoid
  :<|> listShifts

bmo = Eng "bmo"
start = fromGregorian 2015 11 9
end = fromGregorian 2015 12 7
shifts = [Shift start end bmo]

currentRoid :: Maybe Text -> Handler Eng
currentRoid inDuration = return bmo

showRoid :: Text -> Handler Eng
showRoid initials = return bmo

listShifts :: Maybe Text -> Handler [Shift]
listShifts startingAfter = return shifts

app :: Application
app = serve API.shiftsAPI server

runServer :: Port -> IO ()
runServer port = run port app
