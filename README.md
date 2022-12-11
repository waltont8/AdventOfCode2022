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

## Day 5: Supply Stacks
Just some really hacky speed parsing and then follow the rules. This is one that felt really nasty in haskell. I've always said that some questions in AoC are better done in C++ than Haskell, but I had a realization. To do this quickly question, I needed to write some terrible single-use code, which haskell really pushes back on and C++ doesn't. A more robust solution to this with a real parser would be really nice to do in haskell. It's easier to write bad code in C++ than in Haskell.

## Day 6: Tuning Trouble
I'm glad this was easy. It's been quite a day.

## Day 7: No Space Left On Device
I was so tired today, far too tired to do this properly, so I did a quick C++ hack and called it a day. Edit: Went back and added a hs version.

## Day 8: Day 8: Treetop Tree House
Not super happy about having different visibility and counting functions, they're basically the same. I also thought about running the isVisible function over an array of direction functions which might have looked neater. Time is the fire in which we burn.

## Day 9: Rope Bridge
That took a while. I had to go back and retrofit arrays of tail knots into the code for part 2. I do like how you get Read for free if you make your data names match the text in the file.

## Day 10: Cathode-Ray Tube
If the words in the input text all started with a capital letter then I could use derived Read directly and wouldn't need any parsing at all. My code would be a lot cleaner every year.
```
###  ###  ####  ##  ###   ##  ####  ##  
#  # #  #    # #  # #  # #  #    # #  # 
#  # ###    #  #    #  # #  #   #  #  # 
###  #  #  #   # ## ###  ####  #   #### 
#    #  # #    #  # # #  #  # #    #  # 
#    ###  ####  ### #  # #  # #### #  # 
```

## Day 11: Monkey in the Middle
That was a very strange question. Didn't take too long to remember how megaparsec works. Took ages to debug. Part 2 was just a guess, I didn't base it on any reasoning. Seems to work...
