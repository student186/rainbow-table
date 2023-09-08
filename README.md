# Rainbow-Table
A Haskell program that generates a rainbow table to crack a password based on a given hash value.

## Files
- RainbowAssign.hs: A module used in rainbow.hs which contains functions for hashing passwords, building, reading and writing tables. <br>
- rainbow.hs: The main module which contains functions for reducing hashes, creating the table, reversing the hashes and testing the table's functionality. <br>

## Setup
1. Install the Glasgow Haskell Compiler (GHC) <br>
2. Open command prompt and navigate to the src folder <br>
3. Type 'ghci' in the command prompt to start it <br>
4. Type ':l rainbow.hs' to load the Haskell source file

## Demo
Testing the rainbowTable function:
```
*Main> :t rainbowTable 
rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd 
*Main> rainbowTable 0 ["abcdeabc"] 
fromList [(1726491528,"abcdeabc")] 
*Main> rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"] 
fromList [(-1993856529,"abcdeabc"),(1781092264,"aabbccdd"),(2135711886,"eeeeeeee")] 
```
\
Creating a rainbow table and writing the results to a file: 
```
*Main> buildTable rainbowTable nLetters pwLength width height 
fromList [(-2146640490,"aaebebca"),(-2143707111,"dadacbac"),(-2140068575,"daccadab"),(-2137272861,"beaadeec"),...
*Main> generateTable
```
\
Testing the findPassword function:
```
*Main> let table = rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"]
*Main> findPassword table 40 1726491528
Just "abcdeabc"
*Main> findPassword table 40 1726491529
Nothing
```
