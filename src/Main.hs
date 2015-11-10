module Main where

import Control.Monad
import System.Environment

import qualified Control.Exception as Exception
import Shifts.Server (runServer)

-- | Main application init
main :: IO ()
main = do
  let port = 8081 :: Int
  putStrLn ("Starting on port " ++ show port ++ "...")
  Exception.catch
    (runServer port)
    (\ Exception.UserInterrupt -> putStrLn "\nStopping...")
