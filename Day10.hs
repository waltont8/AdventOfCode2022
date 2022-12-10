module Lib
    ( advent
    ) where

import Control.Arrow
import Data.List.Split
import Data.Char

data Step = Noop | Addx Int deriving (Eq, Show, Read)

parse :: String -> Step
parse s = read $ ((toUpper $ head s) : (tail s))

advent :: IO ()
advent = do
        input <- fmap (lines >>> map parse) $ readFile "input.txt"
        let (x,xs) = foldl (\(x,xs) s -> (adv (x,xs) s)) (1,[]) input
        print $ ( zip [1..] >>> map part1 >>> sum) xs
        mapM_ print $ (zip (cycle [0..39]) >>> map part2 >>> chunksOf 40) xs

part1 (idx, v) = if ((idx-20) `mod` 40 == 0) then idx*v else 0

part2 (idx,v) = if (idx >= v-1 && idx <= v+1) then '#' else ' '

adv :: (Int, [Int]) -> Step -> (Int,[Int])
adv (x,xs) (Noop) = (x,xs++[x])
adv (x,xs) (Addx a) = (x+a, xs++[x,x])
