module Lib
    ( advent
    ) where

import Control.Arrow
import Data.List.Split


advent :: IO ()
advent = do
        -- Part 1
        input <- fmap (lines >>> map (splitOn " ")) $ readFile "input.txt"
        print $ (map score1 >>> sum) input
        print $ (map score2 >>> sum) input


score1 ["A", "X"] = 1 + 3
score1 ["A", "Y"] = 2 + 6
score1 ["A", "Z"] = 3 + 0
score1 ["B", "X"] = 1 + 0
score1 ["B", "Y"] = 2 + 3
score1 ["B", "Z"] = 3 + 6
score1 ["C", "X"] = 1 + 6
score1 ["C", "Y"] = 2 + 0
score1 ["C", "Z"] = 3 + 3

score2 ["A", "X"] = 0 + 3
score2 ["A", "Y"] = 3 + 1
score2 ["A", "Z"] = 6 + 2
score2 ["B", "X"] = 0 + 1
score2 ["B", "Y"] = 3 + 2
score2 ["B", "Z"] = 6 + 3
score2 ["C", "X"] = 0 + 2
score2 ["C", "Y"] = 3 + 3
score2 ["C", "Z"] = 6 + 1
