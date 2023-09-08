# Rainbow-Table
A Haskell program that generates a rainbow table to crack a password based on a given hash value.

## Setup

## Demo

Testing the rainbowTable function
```
*Main> :t rainbowTable 
rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd 
*Main> rainbowTable 0 ["abcdeabc"] 
fromList [(1726491528,"abcdeabc")] 
*Main> rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"] 
fromList [(-1993856529,"abcdeabc"),(1781092264,"aabbccdd"),(2135711886,"eeeeeeee")] 
```
<br/>
Creating a rainbow table and writing the results to a file 
```
*Main> buildTable rainbowTable nLetters pwLength width height 
fromList [(-2146640490,"aaebebca"),(-2143707111,"dadacbac"),(-2140068575,"daccadab"),(-2137272861,"beaadeec"),...
*Main> generateTable
```
<br/>
Testing the findPassword function
```
*Main> let table = rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"]
*Main> findPassword table 40 1726491528
Just "abcdeabc"
*Main> findPassword table 40 1726491529
Nothing
```
