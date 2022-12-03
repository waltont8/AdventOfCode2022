module Lib
    ( advent
    ) where

import Control.Arrow
import Data.Char
import Data.List

advent :: IO ()
advent = do
        input <- fmap lines $ readFile "input.txt"
        print $ (map parse >>> map score >>> sum) input
        print $ (parse2 >>> map score >>> sum) input


parse s = head $ j
    where
        l = (length s) `div` 2
        j = (take l s) `intersect` (drop l s)

parse2 (a:b:c:xs) = (head shared) : (parse2 xs)
    where
        shared = a `intersect` b `intersect` c
parse2 [] = []

score i
    | isLower i = (ord i) - 96
    | isUpper i = (ord i) - 64 + 26
