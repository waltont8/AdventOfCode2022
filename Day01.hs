module Lib
    ( advent
    ) where

import Control.Arrow
import Data.List

advent :: IO ()
advent = do
        -- Part 1
        input <- fmap (lines >>> listSplit (=="") >>> map (map read) >>> map sum >>> sort) $ readFile "input.txt"
        print $ last input

        -- part 2
        print $ sum $ take 3 $ reverse input



--listSplit (==[]) s
listSplit :: Eq a => ([a] -> Bool) -> [[a]] -> [[[a]]]
listSplit p s = case dropWhile p s of
                [] -> []
                s' -> w : listSplit p s''
                  where (w, s'') = break p s'
