{-# MultiParamTypeClasses #-}

module Main where

import Control.Monad.State

type DFAState q = State q Bool

class DFA q i dfa where
    q0 :: dfa -> q
    t :: dfa -> q -> i -> q
    acc :: dfa -> q -> Bool
    run :: dfa -> [i] -> DFAState q
    run d [] = do
        q <- get
        -- 'i' ambiguous in acc
        return $ acc d q
    run d (i:is) = do
        q <- get
        put $ t d q i
        run d is
    -- 'q' ambiguous in run
    accepts :: dfa -> [i] -> Bool
    d `accepts` is = evalState (run d is) (q0 d)

data Q = Q0 | Q1 | Q2 | Q3
    deriving (Eq, Show)

data S = A | B
    deriving (Show)

data Impl = Impl {
    initial :: Q,
    trans :: Q -> S -> Q,
    qfs :: [Q]
}

instance DFA Q S Impl where
    q0 = initial
    t = trans
    acc d q = q `elem` (qfs d)

dfa = Impl { initial=Q0, trans=t, qfs=[Q3] }
    where t Q0 A = Q1
          t Q0 B = Q0
          t Q1 A = Q1
          t Q1 B = Q2
          t Q2 A = Q1
          t Q2 B = Q3
          t Q3 A = Q1
          t Q3 B = Q0

-- 'q' ambiguous in accepts
res = map (\is -> (dfa `accepts` is, is)) [ [A, B, A, B, B], [A, A, B, A] ]
