import Data.List
import qualified Data.Set as Set

generator2 :: [(String, String, String, String, String)]
generator2 =
  [ (s1, s2, s3, s4, s5)
    | s1 <- map show [123..987], noRepeats s1, noZeroes s1
    , s2 <- map show [12..98], noRepeats s2, noZeroes s2, contains s1 s2
    , s3 <- permutations s1
    , s4 <- map show [12..98], noRepeats s4, noZeroes s4, contains s1 s4
    , s5 <- permutations s1
    , checkFirst s1 s2
  ]

contains :: [Char] -> [Char] -> Bool
contains xs ys = null (ys \\ xs)

checkFirst :: [Char] -> [Char] -> Bool
checkFirst (x:xs) (y:ys)
    | x == y = False
    | otherwise = True

noRepeats :: String -> Bool
noRepeats str = Set.size (Set.fromList str) == length str

noZeroes :: String -> Bool
noZeroes = notElem '0'

tester2 :: (String, String, String, String, String) -> Bool
tester2 (s1, s2, s3, s4, s5)
  | (read s1 + read s3 + read s5 < 2000) && (read s1 - read s2 == read s3) && (read s3 - read s4 == read s5) = True
  | otherwise = False

main = print (filter tester2 generator2)