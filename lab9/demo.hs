import qualified Data.Foldable as F

{-
    importul de mai sus e un fix in caz ca aveti probleme
    cu importul de Foldable (de regula nu prea se intampla)
-}

-- polimorfism parametric
myLength :: [a] -> Integer
myLength [] = 0
myLength (x:xs) = 1 + myLength xs


-- polimorfism ad-hoc, datorita lui Eq a, caci trebuie sa mearga (==) pe elementele de tip a
myElem :: Eq a => a -> [a] -> Bool
myElem x [] = False
myElem x (l:list) = if x == l then True else myElem x list


data Point = CreatePoint {
    x :: Int,
    y :: Int
}

-- instantiem Eq pentru Point, ca sa putem folosi ==
instance Eq Point where
    CreatePoint x1 y1 == CreatePoint x2 y2 = x1 == x2 && y1 == y2
    p1 /= p2 = not (p1 == p2)

-- forme geometrice
-- ne construim o clasa cu care putem calcula perimetrul si aria unei forme geometrice
class Calculate a where
    dummyFunction :: a -> Integer
    dummyFunction _ = 0 -- functie definita direct in clasa

    calculateArea :: a -> Double
    calculatePerimeter :: a -> Double

data Square = CreateSquare {
    side :: Double
} deriving (Show, Ord, Eq) -- automat putem folosi ==, < si show pe o variabila de tip Square, Haskellul face automat mecanismul de <, == si toString

data Rectangle = CreateRectagle {
    width :: Double,
    height :: Double
} deriving Show

data Circle = CreateCircle {
    radius :: Double
}

data Triangle = RegularTriangle {
    firstSide :: Double,
    secondSide :: Double,
    thirdSide :: Double
} | EquilateralTriangle {
    triangleSide :: Double
} deriving Eq

-- instantiem Calculate pentru fiecare forma geometrica
instance Calculate Square where
    calculateArea (CreateSquare side) = side * side
    calculatePerimeter (CreateSquare side) = 4 * side
    
instance Calculate Rectangle where
    calculateArea (CreateRectagle width height) = width * height
    calculatePerimeter (CreateRectagle width height) = 2 * (width + height)

instance Calculate Circle where
    calculateArea (CreateCircle radius) = 3.14 * radius * radius
    calculatePerimeter (CreateCircle radius) = 2 * 3.14 * radius

-- instantiem doar Eq pentru Rectangle (avem deriving Show)
instance Eq Rectangle where
    CreateRectagle width1 height1 == CreateRectagle width2 height2 = (width1 == width2) && (height1 == height2)
    -- d1 /= d2 = not (d1 == d2) -- este optional, deoarece este deja definit in clasa Eq

instance Ord Rectangle where
    d1@(CreateRectagle width1 height1) <= d2@(CreateRectagle width2 height2) = ((calculateArea d1) <= (calculateArea d2)) && ((calculatePerimeter d1) <= (calculatePerimeter d2))
    d1 > d2 = not (d1 <= d2)  -- este optional, deoarece este deja definit in clasa Ord
    d1@(CreateRectagle width1 height1) < d2@(CreateRectagle width2 height2) = ((calculateArea d1) < (calculateArea d2)) && ((calculatePerimeter d1) < (calculatePerimeter d2))
    d1 >= d2 = not (d1 < d2) -- este optional, deoarece este deja definit in clasa Ord

-- instantiem Show si Eq pentru Circle
instance Show Circle where
    show (CreateCircle radius) = "Cercul cu raza " ++ (show radius)

instance Eq Circle where
    (CreateCircle radius1) == (CreateCircle radius2) = (radius1 == radius2)
    d1 /= d2 = not (d1 == d2)

-- instantiem show pentru Triangle
instance Show Triangle where
    show (RegularTriangle x y z) = "Triunghiul cu laturile de lungime: " ++ (show x) ++ ", " ++ (show y) ++ ", " ++ (show z)
    show (EquilateralTriangle x) = "Triunghiul echilateral cu laturile cu lungimea " ++ (show x)

class Container t where
    contents :: t a -> [a]

class Invertible a where
    invert :: a -> a

-- containere - de regula pe tipuri definite de noi

data List a = EmptyList | Cons a (List a)
-- EmptyList - constructorul pentru lista goala
-- Cons - constructor pentru o lista cu cel putin un element
-- Cons are 2 membrii: head-ul listei si restul listei
insertList :: a -> List a -> List a
insertList value EmptyList = Cons value EmptyList
insertList value (Cons val list) = Cons value (Cons val list)

fromNormalList :: [a] -> List a
fromNormalList lst = foldr (\x acc -> Cons x acc) EmptyList lst

addComma :: Show a => List a -> [Char]
addComma EmptyList = ""
addComma _ = ", "

printHelper :: Show a => List a -> [Char] -> [Char]
printHelper EmptyList acc = acc
printHelper (Cons value lst) acc = printHelper lst $ acc ++ show value ++ addComma lst

instance Show a => Show (List a) where
    show EmptyList = "[]"
    show lst = "[" ++ (printHelper lst "") ++ "]"

instance Eq a => Eq (List a) where
    (==) EmptyList EmptyList = True
    (==) (Cons value1 lst1) (Cons value2 lst2) = value1 == value2 && lst1 == lst2
    (==) _ _ = False

instance Ord a => Ord (List a) where
    (<) lst1 lst2 = let
        l1 = length $ contents lst1
        l2 = length $ contents lst2
        in l1 < l2
    (<=) lst1 lst2 = let
        l1 = length $ contents lst1
        l2 = length $ contents lst2
        in l1 <= l2

instance Functor List where
    fmap f EmptyList = EmptyList
    fmap f (Cons value lst) = Cons (f value) (fmap f lst)

instance F.Foldable List where
    foldr f acc EmptyList = acc
    foldr f acc (Cons value lst) = F.foldr f (f value acc) lst

instance Container List where
    contents lst = foldl (\acc x -> x : acc) [] $ F.foldr (:) [] lst

instance Invertible (List a) where
    invert = fromNormalList . reverse . contents