import Data.Maybe

primeHelper :: Integer -> Integer -> Bool
primeHelper n div 
    | n < 2 = False
    | div == n = True
    | n `mod` div == 0 = False
    | otherwise = primeHelper n (div + 1)

prime :: Integer -> Bool
prime n = primeHelper n 2

-- naturals = [2..]

-- primePairs = [(x, y) | x <- naturals, y <- naturals, prime x, prime y]

primesDecomposition :: Integer -> (Integer, Integer)
primesDecomposition n = let
    pairs = [(x, n - x) | x <- [2..n], prime x, prime (n - x), x <= n - x]
    in if null pairs 
        then error "nu se poate descompune in numere prime" 
        else head pairs

primesDecompositionWithTypes :: Integer -> Maybe (Integer, Integer)
primesDecompositionWithTypes n = let
    pairs = [(x, n - x) | x <- [2..n], prime x, prime (n - x), x <= n - x]
    in if null pairs 
        then Nothing 
        else Just $ head pairs
