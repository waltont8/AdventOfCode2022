# AdventOfCode2022
Advent Of Code 2022 Haskell solutions
https://adventofcode.com/2022


## Day 1: Calorie Counting
I keep re-using this listSplit function I wrote for AoC in 2018. Always feels like I shouldn't have to do that.
Take the last N elements is an interesting question in haskell. Input data is tiny for AoC so just reverse the list was fastest to type in.
```
--listSplit (==[]) s
listSplit :: Eq a => ([a] -> Bool) -> [[a]] -> [[[a]]]
listSplit p s = case dropWhile p s of
                [] -> []
                s' -> w : listSplit p s''
                  where (w, s'') = break p s'
```
