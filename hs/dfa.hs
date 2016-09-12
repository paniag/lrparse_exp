module Main where

import Control.Monad.State

type DFAState q = State q Bool

data Q = Q0 | Q1 | Q2 | Q3
    deriving (Eq, Show)

data S = A | B
    deriving (Show)

data DFA = DFA {
    q0 :: Q,
    t :: Q -> S -> Q,
    qfs :: [Q]
}

run :: DFA -> [S] -> DFAState Q
run d [] = do
    q <- get
    return $ q `elem` (qfs d)
run d (i:is) = do
    q <- get
    put $ t d q i
    run d is

accepts :: DFA -> [S] -> Bool
d `accepts` is = evalState (run d is) (q0 d)

dfa = DFA { q0=Q0, t=trans, qfs=[Q3] }
    where trans Q0 A = Q1
          trans Q0 B = Q0
          trans Q1 A = Q1
          trans Q1 B = Q2
          trans Q2 A = Q1
          trans Q2 B = Q3
          trans Q3 A = Q1
          trans Q3 B = Q0

main :: IO ()
main = putStr $ foldr (\is s -> show (dfa `accepts` is, is) ++ "\n" ++ s) "" [
    [B, A, B, B, A, B, B],
    [A, B, A, B, B],
    [A, A, B, A],
    [],
    [B, B, A]
    ]
