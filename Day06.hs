module Lib
    ( advent
    ) where

import Data.List

advent :: IO ()
advent = do
        input <- readFile "input.txt"
        print $ (length input) - (length $ findStart input)

findStart l = if (first14 == nub first14) then (drop 14 l) else (findStart (drop 1 l))
    where
        first14 = take 14 l
        first4 = take 4 l
