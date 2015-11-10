{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module Shifts.Types (Eng(..)) where

import Data.Aeson
import Data.Text
import GHC.Generics

data Eng = Eng { _initials :: Text }
  deriving (Show, Eq, ToJSON, FromJSON, Generic)
