module Main where

-- newtype State s a = State { runState :: s -> (a, s) }
-- 
-- instance Monad (State s) where
--   return a = State $ \s -> (a, s)
--   m >>= k = State $ \s -> let (a, s') = runState m s
--                           in runState (k a) s'
-- 
-- show :: Show a => State [a] () -> String
-- show f = Prelude.show $ runState f []
-- 
-- f :: State Int Int
-- f = State $ \s -> (s*s, s+1)
-- 
-- as = [2, 3, 5]
-- 
-- res = do a <- as
--          return $ runState f a
-- 
-- resb = foldl (\a s -> a ++ [runState f s]) [] as
-- 
-- resc = foldl (\a s -> a ++ [(\x -> (x*x,x+1)) s]) [] as
-- 
-- res2 = do a <- as
--           return $ a + 1
-- 
-- res2b = map (\a -> a+1) as


-- State s a
-- s :: i -> q
-- a :: Bool

import Control.Monad.State

--type DFAstate q i = State q Bool

-- class DFA q i where
--     initial :: q
--     transition :: q -> i -> q
--     final :: q -> Bool
-- 
-- instance DFA Int Char where
    
-- newtype DFA q i = {
--     q0 :: q,
--     t :: q -> i -> q,
--     final :: q -> Bool
-- }


runner :: Eq q => (q -> i -> q) -> [q] -> [i] -> State q Bool
runner _ qfs [] = do
    q <- get
    return $ q `elem` qfs
runner t qfs (i:is) = do
    q <- get
    put (t q i)
    runner t qfs is

evalDFA :: Eq q => q -> (q -> i -> q) -> [q] -> [i] -> Bool
evalDFA q0 t qfs is = evalState (runner t qfs is) q0
                            
                             

--           runner (i:is) = do (_, next) <- get
--                              return $ State $ \nx ->
--                                 let q = nx i
--                                     fn = q `elem` qfs
--                                 in (fn, t q)


cons :: a -> [a] -> [a]
cons a as = a:as

-- newtype DFA s = DFA { runDFA :: (i, s) -> s }

-- instance Monad (DFA s) where
--   return a = DFA $ 
