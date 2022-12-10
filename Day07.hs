module Lib
    ( advent
    ) where

import Control.Arrow
import Data.Char
import Data.List
import Data.List.Split
import qualified Data.Map as M

data Entry = Dir [String] | File Int deriving (Show, Eq)


advent :: IO ()
advent = do
  sizes <- fmap (lines >>> map words >>> parse) $ readFile "input.txt"
  print $ sum $ filter (<=100000) $ M.elems sizes
  print $ minimum $ filter (\d -> sizes M.! ["/"] - d <= 40000000) $ M.elems sizes

parse input = M.map (calculateSizes fs) fs
      where
        (fs, _) = foldl step (M.empty, []) input

calculateSizes fs e = sum $ map row e
 where
  row (Dir d) = calculateSizes fs (fs M.! d)
  row (File s) = s

step (fs, pwd) ["$", "cd", ".."] = (fs, tail pwd)
step (fs, pwd) ["$", "ls"]       = (fs, pwd)
step (fs, pwd) ["$", "cd", dir]  = (M.insert (dir : pwd) [] fs, dir : pwd)
step (fs, pwd) ["dir", name]     = (M.adjust (Dir (name : pwd) :) pwd fs, pwd)
step (fs, pwd) [sz   , _   ]     = (M.adjust (File (read sz) :) pwd fs, pwd)
