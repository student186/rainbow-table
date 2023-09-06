import RainbowAssign
import System.Random
import qualified Data.Map as Map
import qualified Data.Maybe as Maybe


------------------ Parameters ------------------ 
pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width = 40              -- length of each chain in the table
height = 1000           -- number of "rows" in the table
filename = "table.txt"  -- filename to store the table


------------------ Reducing ------------------ 
-- maps a hash value to an arbitrary password; it uses two helper functions convBaseN and toPasswd
pwReduce :: Hash -> Passwd
pwReduce hashVal = toPasswd (convBaseN (fromEnum hashVal) nLetters 0)

-- converts hValue from base 10 to base nLetters and takes pwLength least significant digits
convBaseN :: Int -> Int -> Int -> [Int]
convBaseN hVal base digCount
    | digCount < pwLength = (convBaseN (hVal `div` base) base (digCount + 1)) ++ [hVal `mod` base]
    | otherwise = []

-- converts the result (a list of remainders of size pwLength) from convBaseN to a string by converting each element of the list to a letter
toPasswd :: [Int] -> Passwd
toPasswd [] = ""
toPasswd (x:xs) = toLetter x : toPasswd xs


------------------ The Map Data Structure ------------------ 
-- generates a rainbow table, given a list of initial passwords; it uses a helper function calcHash
rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable width passList = Map.fromList (zip (calcHash width passList 0) passList)

-- calculates the final hash values for each pass in initial passList by applying hash/reduce tabWidth times to each initial pass
calcHash :: Int -> [Passwd] -> Int -> [Hash]
calcHash tabWidth passList count
    | count == tabWidth = map pwHash passList
    | otherwise = calcHash tabWidth (map (pwReduce.pwHash) passList) (count + 1)


------------------ Reversing Hashes ------------------     
-- reverses a hash to the corresponding password, if possible; it uses two helper functions findRows and searchRows.
findPassword :: Map.Map Hash Passwd -> Int -> Hash -> Maybe Passwd
findPassword rTable width hValue = searchRows (findRows rTable width hValue) width hValue 0

-- find all candidate rows (list of initial passwords whose final hash equals hValue)
findRows :: Map.Map Hash Passwd -> Int -> Hash -> [Passwd]
findRows rTable tabWidth hValue = Maybe.mapMaybe (\hash -> Map.lookup hash rTable) hashTable  -- list of values (initial passwords) whose corresponding key (final hash) is from hashTable
    where
        hashes = take (tabWidth + 1) (iterate (pwHash.pwReduce) hValue) -- list of hashes of length tabWidth + 1 (+1 for hash 0 == hValue)
        hashTable = filter (\hash -> Map.member hash rTable) hashes     -- list of hashes that are in rainbow table

-- check each candidate to see if pass corresponding to hValue lies between the chain
searchRows :: [Passwd] -> Int -> Hash -> Int -> Maybe Passwd
searchRows [] _ _ _ = Nothing
searchRows (x:xs) tabWidth hValue count
    | pwHash x == hValue = Just x
    | pwHash x /= hValue && count <= tabWidth = searchRows (pwReduce (pwHash x) : xs) tabWidth hValue (count + 1)
    | otherwise = searchRows xs tabWidth hValue 0
  

------------------ Creating, Reading, and Writing Tables ------------------  
-- generate a new table and save it to disk
generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

-- read back the generated table
test1 = do
  table <- readTable filename
  return (Map.lookup 0 table) -- can modify this line for testing

  
------------------ Further Testing ------------------
-- this function tries to crack n randomly generated passwords and displays the results
test2 :: Int -> IO ([Passwd], Int)
test2 n = do
  table <- readTable filename
  pws <- randomPasswords nLetters pwLength n
  let hs = map pwHash pws
  let result = Maybe.mapMaybe (findPassword table width) hs
  return (result, length result)

-- optional main function to use if code is compiled:
-- ghc -O2 --make -Wall rainbow.hs
-- ./rainbow 
main :: IO ()
main = do
  generateTable
  res <- test2 10000
  print res
