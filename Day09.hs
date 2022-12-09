module Lib
    ( advent
    ) where

import Control.Arrow
import Data.Char
import Data.List
import Data.List.Split
import qualified Data.Set as S

data Direction = L | U | D | R deriving (Show, Read, Eq)
data Step = Step Direction Int deriving (Show, Eq)
type Point = (Int, Int)

advent :: IO ()
advent = do
        input <- fmap (lines >>> map parse) $ readFile "input.txt"
        let (p1,_,_) = foldl (\(s,t,h) step -> takeStepMulti s t h step ) (S.empty, (take 1 $ repeat (0,0)), (0,0)) input
        let (p2,_,_) = foldl (\(s,t,h) step -> takeStepMulti s t h step ) (S.empty, (take 9 $ repeat (0,0)), (0,0)) input
        print $ length p1
        print $ length p2

takeStepMulti :: S.Set Point -> [Point] -> Point -> Step -> (S.Set Point, [Point],Point)
takeStepMulti s t h step@(Step dir 0) = (s, t, h)
takeStepMulti s tArray (hx,hy) step@(Step dir dist) = takeStepMulti (S.insert (ftx,fty) s) (tail tArray') (hx',hy') (Step dir (dist-1))
    where
        (hx',hy') = moveHead hx hy step
        tArray' = updateTailArray ((hx',hy'):tArray) 
        (ftx,fty) = last tArray'

updateTailArray :: [Point] ->  [Point]
updateTailArray (h@(hx,hy):(tx,ty):xs) = (h:(updateTailArray ((tx',ty'):xs)))
    where
        (txm,tym) = tailMove (tx-hx) (ty-hy)
        (tx',ty') = (tx-txm, ty-tym)
updateTailArray (x:[]) = [x]


tailMove x y
    | ax > 1 || ay > 1 = (if ax > 1 then x `div` 2 else x, 
                          if ay > 1 then y `div` 2 else y)
    | otherwise = (0,0)
        where
            ax = abs x
            ay = abs y

moveHead x y (Step U dist) = (x, y-1)
moveHead x y (Step D dist) = (x, y+1)
moveHead x y (Step L dist) = (x-1, y)
moveHead x y (Step R dist) = (x+1, y)

parse :: String -> Step
parse s = Step dir dist
    where
        [w,n] = splitOn " " s
        -- Match case for default read
        dir = read $ toUpper (head w) : map toLower (tail w)
        dist = read n
