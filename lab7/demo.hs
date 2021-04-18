import Data.Maybe

-- type - reprezinta un alias, mai jos avem alias-uri pentru coada si pentru stiva, implementate ca liste
type Stack a = [a]
type Queue a = [a]
type Point = (Int, Int)

createStack :: Stack a
createStack = []

pushStack :: a -> Stack a -> Stack a
pushStack value [] = [value]
pushStack value l = l ++ [value]

popStack :: Stack a -> Stack a
popStack [] = []
popStack l = init l

mainStack = do
    print $ pushStack 79 $ pushStack 69 createStack
    print $ pushStack 10 $ pushStack 79 $ pushStack 69 createStack
    print $ popStack $ pushStack 10 $ pushStack 79 $ pushStack 69 createStack

createQueue :: Queue a
createQueue = []

pushQueue :: a -> Queue a -> Queue a
pushQueue value [] = [value]
pushQueue value list = list ++ [value]

popQueue :: Queue a -> Queue a
popQueue [] = []
popQueue (x:xs) = xs

mainQueue = do
    print $ pushQueue 79 $ pushQueue 69 createQueue
    print $ pushQueue 10 $ pushQueue 79 $ pushQueue 69 createQueue
    print $ popQueue $ pushQueue 10 $ pushQueue 79 $ pushQueue 69 createQueue


-- data - aici putem avea cel putin un constructor pentru tipul de date (constructorul este similar ca concept cu constructorul de clase din Java)
data Square = CreateSquare Double deriving Show -- aici avem un singur membru (anonim)
data Triangle = CreateRegularTriangle Integer Integer Integer | CreateEquilateralTriangle Integer deriving Show -- mai multi constructori
-- perimetrul unui patrat
perimeterSquare :: Square -> Double
perimeterSquare (CreateSquare side) = 4 * side
-- pentru ca SquareDouble are un membru anonim, folosind pattern matching ca sa il putem accesa, ca sa putem calcula perimetrul unui patrat

mainSquare = do
    print $ perimeterSquare $ CreateSquare 10

-- tipuri enumerate - functioneaza ca enum din C / Java
data Color = Red | Black | Green | Blue | White deriving Show
isNonColor :: Color -> Bool
isNonColor Black = True
isNonColor White = True
isNonColor _ = False -- restul de culor

mainColor = do
    print $ isNonColor Blue
    print $ isNonColor Black

-- tipuri parametrizate / generice - similar cu clasele generice din Java
data Circle a = CreateCircle a -- a reprezinta tipul membrului din Circle
{-
    analogie cu Java
    class Circle<T> {
        T radius;
        Circle (T radius) {
            this.radius = radius;
        }
    }
-}

-- recorded data (tipuri inregistrate) - aici, avem membrii cu nume, in mod explicit
data Rectagle = CreateRectangle {
    lengthRectangle :: Double,
    widthRectangle :: Double    
} deriving Show
perimeterRectangle :: Rectagle -> Double
perimeterRectangle rectangle = ((widthRectangle rectangle) + (lengthRectangle rectangle)) * 2
-- putem sa facem si ca mai sus, cand aveam membrii anonimi
-- perimeterRectangle (CreateRectangle lengthRec widthRec) = (widthRec + lengthRec) * 2

mainRectangle = do
    print $ perimeterRectangle $ CreateRectangle 6 9
    print $ widthRectangle $ CreateRectangle 6 9


-- tipuri recursive (pot fi si ele generice)
data BST a = Nil | CreateNode a (BST a) (BST a) -- arbore binar de cautare
{-
    analogie cu C (struct) - arbore binar de cautare (exemplul de mai sus)
    struct node { 
        int key; 
        struct node *left, *right; 
    }; 
-}

data List a = EmptyList | Cons a (List a) deriving Show
-- EmptyList - constructorul pentru lista goala
-- Cons - constructor pentru o lista cu cel putin un element
-- Cons are 2 membrii: head-ul listei si restul listei
insertList :: a -> List a -> List a
insertList value EmptyList = Cons value EmptyList
insertList value (Cons val list) = Cons value (Cons val list)

-- newtype - spre deosebire, are un singur constructor si un singur membru
newtype Celsius = MakeCelsius Float deriving Show
newtype Pair a b = Pair { getPair :: (a, b) } deriving Show

-- Maybe
primeHelper :: Integer -> Integer -> Bool
primeHelper n div 
    | n < 2 = False
    | div == n = True
    | n `mod` div == 0 = False
    | otherwise = primeHelper n (div + 1)

prime :: Integer -> Bool
prime n = primeHelper n 2

primesDecomposition :: Integer -> Maybe (Integer, Integer)
primesDecomposition n = let
    pairs = [(x, n - x) | x <- [2..n], prime x, prime (n - x), x <= n - x]
    in if null pairs 
        then Nothing 
        else Just $ head pairs