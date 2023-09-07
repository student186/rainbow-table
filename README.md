# Rainbow-Table
A Haskell program that generates a rainbow table to crack a password based on a given hash value.

## Setup

## Demo
```
*Main> :t rainbowTable <br>
*Main> rainbowTable 0 ["abcdeabc"] <br>
fromList [(1726491528,"abcdeabc")] <br>
*Main> rainbowTable 40 ["abcdeabc", "aabbccdd", "eeeeeeee"] <br>
fromList [(-1993856529,"abcdeabc"),(1781092264,"aabbccdd"),(2135711886,"eeeeeeee")] <br>
```
