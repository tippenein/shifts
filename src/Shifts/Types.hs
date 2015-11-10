{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Shifts.Types
  (
    Eng(..)
  , Shift(..)
  ) where

import Control.Monad (liftM)
import Data.Aeson
import Data.Text
import Data.Time
import GHC.Generics

data Shift = Shift { _startDay :: Day, _endDay :: Day, _engOwner :: Eng }
  deriving (Show, Eq, ToJSON, FromJSON, Generic)

data Eng = Eng { _initials :: Text }
  deriving (Show, Eq, ToJSON, FromJSON, Generic)

parseDate :: String -> Day
parseDate = parseTimeOrError True defaultTimeLocale "%Y-%m-%d"

instance FromJSON Day where
  parseJSON (Object v) = liftM parseDate (v .: "date")

instance ToJSON Day where
  toJSON = toJSON . showGregorian
