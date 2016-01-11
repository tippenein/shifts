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

instance Ord Shift where
  (Shift s1 _ _) `compare` (Shift s2 _ _) = s1 `compare` s2

data Shift = Shift
  { _startDay :: Day
  , _endDay   :: Day
  , _engOwner :: Eng
  }
  deriving (Show, Eq, ToJSON, Generic)

data Eng = Eng { _initials :: Text }
  deriving (Show, Eq, ToJSON, Generic)

parseDate :: String -> Day
parseDate = parseTimeOrError True defaultTimeLocale "%Y-%m-%d"

instance FromJSON Day where
  parseJSON (Object v) = liftM parseDate (v .: "date")
  parseJSON _ = fail "invalid"

instance ToJSON Day where
  toJSON = toJSON . showGregorian
