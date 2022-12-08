module Lib
    ( advent
    ) where

import Control.Arrow
import Data.Char
import Data.List
import qualified Data.Map as M
import qualified Data.Set as S

type Grid = M.Map (Int, Int) Int

advent :: IO ()
advent = do
        input <- fmap (lines >>> parse) $ readFile "input.txt"
        print $ length $ part1 input
        print $ maximum $ part2 input

parse input =  foldl (\m (n,i) -> M.insert (n `mod` width, n `div` width) (digitToInt i) m) (M.empty :: Grid) $ zip [0..] (concat input)
    where width = length (input!!0)

part1 g = foldl (\s p -> if (isVisible u g p || isVisible d g p || isVisible l g p || isVisible r g p) then (S.insert p s) else s) (S.empty) $ M.toList g

part2 g = foldl (\s p -> S.insert (count u g p * count d g p * count r g p * count l g p) s) (S.empty) $ M.toList g


isVisible f g ((x,y),v) 
    | not (M.member new g) = True
    | (g M.! new) < v = isVisible f g (new,v)
    | otherwise = False
        where
            new = f (x,y)

count f g ((x,y),v) 
    | not (M.member new g) = 0
    | (g M.! new) < v = 1 + count f g (new,v)
    | otherwise = 1
        where
            new = f (x,y)

u (x,y) = (x,y-1)
d (x,y) = (x,y+1)
r (x,y) = (x+1,y)
l (x,y) = (x-1,y)
