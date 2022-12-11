module Lib
    ( advent
    ) where

import Control.Arrow
import Control.Monad
import Data.Char
import Data.List
import Data.List.Split
import Data.Function (on)
import qualified Data.Map as M
import qualified Data.Set as S
import Debug.Trace

import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer

import Data.Void
import Data.List
import Data.Either

type Parser = Parsec Void String

data Monkey = Monkey
  {   mId :: Int
  ,   things :: [Int]
  ,   o :: Int -> Int
  ,   d :: Int
  ,   t :: Int
  ,   f :: Int
  ,   c :: Int
  } deriving Show

instance Show (a -> b) where
    show a = "funcion"

type Mmap = M.Map Int Monkey

-- Parse
parseMonkey :: Parser Monkey
parseMonkey = do
    m <- string "Monkey " *> decimal <* string ":" <* space1
    i <- string "Starting items: " *> sepBy1 decimal (string ", ") <* space1
    o <- string "Operation: new = old " *> ((\c -> if c=='+' then (+) else (*)) <$> asciiChar) <* char ' '
    opBy <- manyTill asciiChar space1
    d <- string "Test: divisible by " *> decimal <* space1
    t    <- string "If true: throw to monkey " *> decimal <* space1
    f   <- string "If false: throw to monkey " *> decimal   
    return Monkey
      {   mId = m
      ,   things = i
      ,   o = \old -> old `o` (if opBy == "old" then old else read opBy)
      ,   d = d
      ,   t = t
      ,   f = f
      ,   c = 0
      }

parseMonkeys :: Parser [Monkey]
parseMonkeys = sepEndBy1 parseMonkey space1



-- For each step
doStep func monks = foldl (doMonkey func) monks [0 .. (M.size monks - 1)]

-- For each monkey
doMonkey update monks n = M.insert n 
        m { things = [], c = c m + length (things m) } 
        (foldl (doItem update m) monks (things m))
  where m = monks M.! n

-- Update Items
doItem :: (Int->Int) -> Monkey -> Mmap -> Int -> Mmap
doItem update m monks thing = M.adjust (\m' -> m' { things = things m' ++ [worry] }) target monks
    where
        worry  = update $ o m thing -- operate on the 
        target = if worry `mod` (d m) == 0 then (t m) else (f m) 

part1 m = (M.elems >>> map c >>> sort >>> reverse >>> take 2 >>> product)
           ((iterate (doStep (`div` 3)) m) !! 20)

part2 m = (M.elems >>> map c >>> sort >>> reverse >>> take 2 >>> product)
           ((iterate (doStep (`mod` divs)) m) !! 10000)
     where divs = product $ M.map d m

advent :: IO ()
advent = do
  input <- readFile "input.txt"
  let monkeys = let Right x = parse parseMonkeys "" input in x
  let monkeyMap = foldl (\m mk -> M.insert (mId mk) mk m) (M.empty :: Mmap) monkeys
  print $ part1 monkeyMap
  print $ part2 monkeyMap
