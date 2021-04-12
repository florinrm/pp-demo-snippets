import Data.List

-- functii
f = \x y -> x + y -- cu lambda
f' x y = x + y -- clasic

-- in Haskell, functiile sunt in mod default curry
g = f 6 -- g va fi o functie cu un singur parametru, se poate rescrie ca g x = f 6 x

-- codul din sectiunea main - do puteti sa-l rulati in terminalul de ghci
main_functions = do
    print $ f 6 9
    print (f' 6 9)
    print (g 9)

-- listele in Haskell sunt omogene, avand in vedere ca este un limbaj tipat
main_add_lists = do
    print $ [1, 2, 3, 4]
    print $ 1 : 2 : 3 : 4 : []
    print $ 1 : [2, 3, 4]
    print $ 1 : 2 : [3, 4]
    print $ [1..4]
    print $ [1, 2..4]

main_lists = do
    print $ [1, 2] ++ [3, 4]
    print $ head [1, 2, 3, 4]
    print $ tail [1, 2, 3, 4]
    print $ last [1, 2, 3, 4]
    print $ init [1, 2, 3, 4]
    print $ elem 3 [1, 2, 3, 4]

-- tuplurile sunt fix ca listele din Racket, adica pot avea elemente de tipuri diferite
main_tuples = do
    print $ (1, 2, "anei ii place de maria ioana", True)
    print $ fst (1, "anei ii place de maria ioana") -- merge doar pe perechi
    print $ snd (1, "anei ii place de maria ioana") -- merge doar pe perechi

main_functionals = do
    print $ map (+ 1) [1, 2, 3, 4] -- in Haskell, map merge pe o singura lista - pentru a face map pe mai multe, folosim zipWith
    print $ filter even [1, 2, 3, 4]
    print $ filter (\x -> x `mod` 2 == 0) [1, 2, 3, 4]
    print $ foldl (+) 0 [1, 2, 3, 4]
    print $ foldr (+) 0 [1, 2, 3, 4]
    print $ foldl (-) 0 [1, 2, 3, 4] -- 0 - 1 - 2 - 3 - 4
    print $ foldr (-) 0 [1, 2, 3, 4] -- 4 - 3 - 2 - 1 - 0
    -- foldl si foldr au ordinea parametrilor la functia lambda diferita! (la Racket era aceeasi!)
    print $ foldl (\acc x -> x : acc) [] [1, 2, 3, 4]
    print $ foldr (\x acc -> x : acc) [] [1, 2, 3, 4]
    print $ zip [1, 2, 3] [4, 5, 6]
    print $ zipWith (+) [1, 2, 3] [4, 5, 6]
    print $ [x | x <- [1..20], mod x 2 == 0]
    print $ [(x, y) | x <- [1..20], y <- [30..40], x `mod` 3 == 0]
    print $ take 10 [x | x <- [0, 2..], x `mod` 3 == 0]

my_repeat :: a -> [a]
my_repeat x = x : my_repeat x

main_infinite_lists = do
    print $ take 10 [1..]
    print $ take 10 [2, 4..]
    print $ take 10 $ repeat 1
    print $ take 10 $ my_repeat 1
    print $ take 10 $ intersperse 2 (repeat 1)
    print $ dropWhile even [2,4,6,7,9,11,12,13,14]
    print $ take 10 $ iterate (+ 1) 1

-- if - then - else
copy_list :: [a] -> [a]
copy_list l = if null l
                then []
                else head l : copy_list (tail l)

-- pattern matching
copy_list2 :: [a] -> [a]
copy_list2 [] = []
copy_list2 (x:xl) = x : copy_list2 xl

-- garzi
copy_list3 :: [a] -> [a]
copy_list3 l
    | null l = []
    | otherwise = head l : copy_list3 (tail l)

-- case of
copy_list4 :: [a] -> [a]
copy_list4 l = case l of
    [] -> []
    (x:xl) -> x : copy_list4 xl

-- if - then - else
factorial :: Integer -> Integer
factorial x = if x == 0 then 1 else x * factorial (x - 1)

-- pattern matching
factorial2 :: Integer -> Integer
factorial2 0 = 1
factorial2 x = x * factorial2 (x - 1)

-- garzi
factorial3 :: Integer -> Integer
factorial3 x 
    | x == 0 = 1
    | otherwise = x * factorial3 (x - 1)

-- case of
factorial4 :: Integer -> Integer
factorial4 x = case x of
    0 -> 0
    _ -> x * factorial4 (x - 1)

-- cu let
f1 a = 
    let c = a
        b = a + 1
    in (c + b) -- let din Racket

g1 a = 
    let c = a
        b = c + 1
    in (c + b) -- let* din Racket

h1 a = 
    let c = b
        b = a + 1
    in (c + b) -- letrec din Racket, aici nu avem eroare datorita evaluarii lenese

-- cu where
f2 a = (c + b)
    where
        c = a
        b = a + 1  -- let din Racket

g2 a = (c + b)
    where
        c = a
        b = c + 1  -- let* din Racket

h2 a = (c + b)
    where
        c = b
        b = a + 1  -- letrec din Racket, aici nu avem eroare datorita evaluarii lenese

-- point wise vs point free
square x = x * x
inc x = x + 1

-- point-wise
some_func x = inc (square (x + 2))

-- point-free
some_func_point_free = inc . square . (+ 2)
some_func_point_free2 = inc . square . (2 +)