{-# LANGUAGE OverloadedStrings #-}
module Shifts.Server (runServer) where

import Control.Monad.Trans.Either
import Data.Text
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

bmo = Eng "bmo"

currentRoid :: Handler Eng
currentRoid = return bmo

showRoid :: Text -> Handler Eng
showRoid initials = return bmo

app :: Application
app = serve API.shiftsAPI server

runServer :: Port -> IO ()
runServer port = run port app
