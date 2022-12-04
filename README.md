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

## Day 2: Rock Paper Scissors
Yeah, I mean, sure, I could have done something with types or constants or ascii values, but I like the sound the keyboard makes when you quickly type in patterns like this.

## Day 3: Rucksack Reorganization
Nothing too exciting going on yet. Just using Data.List intersect. Looks like the image is going to be a map, you can just see a river inlet starting to form at the bottom.

## Day 4: Camp Cleanup
Similar to day 2, easier to just write it out long hand than do anything clever.
