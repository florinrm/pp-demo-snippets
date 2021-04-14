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

primesDecomposition n = head [(x, n - x) | x <- [2..n], prime x, prime (n - x), x <= n - x]