module Lib
    ( advent
    ) where

import Control.Arrow
import Data.Char
import Data.List
import Data.List.Split
import qualified Data.Map as M

advent :: IO ()
advent = do
        input <- fmap lines $ readFile "input.txt"
        let moves = map parseMove $ drop 10 input
        let start = parseStart input
        print $ score $ process start moves

-- Move the boxes
process :: (M.Map Int [char]) -> [[Int]] -> (M.Map Int [char])
process inp mvs = foldl (\inp [a,f,t] -> move inp a f t) inp mvs

-- Do a single move command
-- reverse needed for part 1
move :: (M.Map Int [char]) -> Int -> Int -> Int -> (M.Map Int [char])
move m a f t = m''
    where
        oldfrom = m M.! f
        oldto = m M.! t
        newfrom = drop a oldfrom
        newto =  ({-reverse-}(take a oldfrom)) ++ oldto
        m' = M.insert f newfrom m
        m'' = M.insert t newto m'

-- top of every pile
score :: (M.Map Int [Char]) -> String
score m = foldl (\s (i,a) -> s++[(head a)]) "" (M.toList m)

parseMove :: String -> [Int]
parseMove s = [a,f,t]
    where
        sections = splitOn " " s
        a = read (sections!!1)
        f = read (sections!!3)
        t = read (sections!!5)


parseStart = take 8 
         >>> transpose 
         >>> (["",""]++) 
         >>> every 4 
         >>> map (dropWhile isSpace) 
         >>> zip [1..] 
         >>> M.fromList 

--
every n xs = case drop (n-1) xs of
              y : ys -> y : every n ys
              [] -> []
