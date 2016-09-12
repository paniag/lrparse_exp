module Main where

data Token = INTT Int | IDT String | PLUST | TIMEST | LPARENT | RPARENT

type Stream = [Token]

data Maybe a = Just a | Nothing

-- data Ast = 
-- 
-- data Tree a = Leaf a
--             | Node a [Tree a]
-- 
-- Leaf :: a -> Tree a
-- Node :: a -> [Tree a] -> Tree a
-- 
-- ex :: Tree Int
-- ex = Node 1 [Leaf 2, Leaf 3]

data E = Sum E T
       | Term T
data T = Prod T F
       | Fact F
data F = Parend E
       | Id String

fun :: E -> Int
fun (Sum e t) = 5
fun (Term t) = 3

-- toTree :: E -> Tree String
-- toTree (Sum E T)

-- data Operator = Plus | Times

-- data Ast a = Const a
--            | Op Operator (Ast a) (Ast a)

data Node = Op Operator | Val Value

data Operator = Plus | Times
-- Plus :: Operator
-- Times :: Operator

data Value = Register Int

data Ast = N Node [Ast]

-- 3
three = N (Val (Register 3)) [] :: Ast

-- 1+2
one_plus_two = N (Op Plus) [N (Val (Register 1)) [], N (Val (Register 2)) []] :: Ast

-- data Ast a = Val Value
--            | N Node (Ast a) (Ast a)
