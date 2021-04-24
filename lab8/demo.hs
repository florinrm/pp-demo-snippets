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

-- containere - de regula pe tipuri definite de noi

data BST a = BSTNil | BSTNode a (BST a) (BST a) -- deriving Show

insert :: (Ord a, Eq a) => BST a -> a -> BST a
insert BSTNil elem = BSTNode elem BSTNil BSTNil
insert root@(BSTNode value left right) elem
  | value == elem = root
  | value < elem = BSTNode value left (insert right elem)
  | value > elem = BSTNode value (insert left elem) right 

inorder :: BST a -> [a]
inorder BSTNil = []
inorder (BSTNode root left right) = inorder left ++ [root] ++ inorder right

printLevel :: Show a => Char -> Int -> BST a -> [Char]
printLevel _ _ BSTNil = ""
printLevel tab level (BSTNode root left right) = (replicate level tab) ++ (show root) ++ "\n" 
    ++ (printLevel tab (level + 1) left) 
    ++ (printLevel tab (level + 1) right) 

instance Show a => Show (BST a) where
    show BSTNil = ""
    show (BSTNode root left right) = printLevel '\t' 0 (BSTNode root left right)

class Container t where
    contents :: t a -> [a]

instance Container BST where
    contents BSTNil = []
    contents (BSTNode a left right) = [a] ++ (contents left) ++ (contents right)

class Invertible a where
    invert :: a -> a

instance Invertible (BST a) where
    invert BSTNil = BSTNil
    invert (BSTNode a left right) = BSTNode a (invert right) (invert left)

instance Functor BST where
    fmap f BSTNil = BSTNil
    fmap f (BSTNode a left right) = BSTNode (f a) (fmap f left) (fmap f right)

instance Foldable BST where
    foldr f acc tree = foldr f acc $ inorder tree