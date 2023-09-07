# Rainbow-Table
A Haskell program that generates a rainbow table to crack a password based on a given hash value.

## Setup

## Demo

Testing the rainbowTable function
```
*Main> :t rainbowTable <br>
rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd <br>
*Main> rainbowTable 0 ["abcdeabc"] <br>
fromList [(1726491528,"abcdeabc")] <br>
*Main> rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"] <br>
fromList [(-1993856529,"abcdeabc"),(1781092264,"aabbccdd"),(2135711886,"eeeeeeee")] <br>
```

Creating a rainbow table
```
*Main> buildTable rainbowTable nLetters pwLength width height <br>
fromList [(-2146640490,"aaebebca"),(-2143707111,"dadacbac"),(-2140068575,"daccadab"),(-2137272861,"beaadeec"),... <br>
```
