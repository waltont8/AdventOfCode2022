module Lib
    ( advent
    ) where

import Control.Arrow
import Control.Monad
import Data.List.Split


advent :: IO ()
advent = do
        input <- fmap (lines >>> map parse >>> (map score1 &&& map score2) >>> join (***) sum) $ readFile "input.txt"
        print input

parse :: String -> ((Int,Int),(Int,Int))
parse s = ((read a,read b), (read c,read d))
    where
        [[a,b],[c,d]] = map (splitOn "-") (splitOn "," s)

score1 ((a,b), (c,d))
    | (a>=c) && (b<=d) = 1
    | (c>=a) && (d<=b) = 1
    | otherwise = 0

score2 ((a,b), (c,d))
    | (a>=c) && (a<=d) = 1
    | (b>=c) && (b<=d) = 1
    | (c>=a) && (c<=b) = 1
    | (d>=a) && (d<=b) = 1
    | otherwise = 0
