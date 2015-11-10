{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}
module Shifts.API (shiftsAPI, ShiftsAPI) where

import Data.Proxy
import Data.Text
import Servant.API
import Shifts.Types

shiftsAPI :: Proxy ShiftsAPI
shiftsAPI = Proxy

type ShiftsAPI =
       CurrentRoid
  :<|> ShowRoid
  :<|> ListShifts
  -- :<|> CreateRoid
  -- :<|> UpdateRoid
  -- :<|> DestroyRoid

type ListShifts = "shifts"
    :> QueryParam "in" Text
    :> Get '[JSON] [Shift]

type CurrentRoid = "roids"
    :> QueryParam "in" Text
    :> Get '[JSON] Eng

type ShowRoid = "roids"
    :> Capture "initials" Text
    :> Get '[JSON] Eng

