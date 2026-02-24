import Data.List

main_functionals = do
    print $ [x | x <- [1..20], mod x 2 == 0]
    print $ [(x, y) | x <- [1..20], y <- [30..40], x `mod` 3 == 0]
    print $ take 10 [x | x <- [0, 2..], x `mod` 3 == 0]

my_repeat :: a -> [a]
my_repeat x = x : my_repeat x

naturals1 = [0..]
naturals2 = iter 0
    where iter x = x : iter (x + 1)
naturals3 = iterate (\x -> x + 1) 0  -- SAU
naturals4 = iterate (+ 1) 0


main_infinite_lists = do
    print $ take 10 [1..]
    print $ take 10 [2, 4..]
    print $ take 10 $ repeat 1
    print $ take 10 $ my_repeat 1
    print $ take 10 $ intersperse 2 (repeat 1)
    print $ dropWhile even [2,4,6,7,9,11,12,13,14]
    print $ take 10 $ iterate (+ 1) 1

length $ 3 : [1, 2] -- length (3 : [1, 2])

sum1 xs = foldl (+) 0 xs
sum2 = foldl (+) 0

-- point wise vs point free
square x = x * x
inc x = x + 1

-- point-wise
some_func x = inc (square (x + 2))

-- point-free
some_func_point_free = inc . square . (+ 2)
some_func_point_free2 = inc . square . (2 +)


(length . tail . zip [1,2,3,4]) ("abc" ++ "d")
length . tail . zip [1,2,3,4] $ "abc" ++ "d"

concatMap (\x -> [(x,x+2,x/2)]) [1,3,5]

myIntersperse :: a -> [a] -> [a]
myIntersperse y = foldr (++) [] . map (: [y])