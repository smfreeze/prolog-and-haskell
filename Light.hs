import Data.List

monthDays :: Int -> Int
monthDays 2 = 28
monthDays 4 = 30
monthDays 6 = 30
monthDays 9 = 30
monthDays 11 = 30
monthDays _ = 31

generator1 :: [(Int, Int, Int, Int)]
generator1 =
  [ (i1, i2, i3, i4)
    | i1 <- [0 .. 23],
      i2 <- [0 .. 59],
      i4 <- [1 .. 12],
      i3 <- [1 .. monthDays i4]
  ]
nextDay :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
nextDay (i1, i2, i3, i4) 
  | i3 == monthDays i4 = (i1, i2, 1, if i4 == 12 then 1 else i4 + 1)
  | otherwise = (i1, i2, i3 + 1, i4)
nextMinute :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
nextMinute (i1, i2, i3, i4)
  | i2 == 59 && i1 == 23 = nextDay (i1, i2, i3, i4)
  | i2 == 59 = (i1 + 1, 0, i3, i4)
  | otherwise = (i1, i2 + 1, i3, i4)

sumValues :: [Char] -> Int
sumValues [] = 0
sumValues (x : xs) = digitValue x + sumValues xs

digitValue :: Char -> Int
digitValue '0' = 6
digitValue '1' = 2
digitValue '2' = 5
digitValue '3' = 5
digitValue '4' = 4
digitValue '5' = 5
digitValue '6' = 6
digitValue '7' = 3
digitValue '8' = 7
digitValue '9' = 6
digitValue _ = error "Invalid digit"

format :: (Int, Int, Int, Int) -> (String, String, String, String)
format (i1, i2, i3, i4) = (formatStr i1, formatStr i2, formatStr i3, formatStr i4)

formatStr :: Int -> String
formatStr n | n < 10 = '0' : show n
            | otherwise = show n

allDigitsUnique :: (String, String, String, String) -> Bool
allDigitsUnique (s1, s2, s3, s4) = length digits == length (nub digits)
  where digits = s1 ++ s2 ++ s3 ++ s4

magic :: (Int, Int, Int, Int) -> Bool
magic t@(i1, i2, i3, i4) = prime (numberLit t) && allDigitsUnique (format t)

prime :: Int -> Bool
prime n = not (factorisable 2 n)

factorisable :: Int -> Int -> Bool
factorisable f n
  | f * f <= n = n `mod` f == 0 || factorisable (f + 1) n
  | otherwise = False

numberLit :: (Int, Int, Int, Int) -> Int
numberLit (i1, i2, i3, i4) =
  sumValues (concatMap formatStr [i1, i2, i3, i4])

tester1 :: (Int, Int, Int, Int) -> Bool
tester1 date = 
  let modifiedDate = nextDay date
      avg = (numberLit date + numberLit modifiedDate) `div` 2
  in magic date && magic modifiedDate && avg == numberLit (nextMinute modifiedDate)

main = print (filter tester1 generator1)