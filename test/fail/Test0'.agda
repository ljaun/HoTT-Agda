{-# OPTIONS --without-K #-}

open import lib.Base

module test.fail.Test0 where

data Bool : Type₀ where
  true false : Bool

module _ where

  private
    data #I : Type₀ where
      #zero : #I
      #one : #I

  I : Type₀
  I = #I

  zero : I
  zero = #zero

  one : I
  one = #one

  postulate
    seg : zero == one

  I-elim : ∀ {i} {P : I → Type i} (zero* : P zero) (one* : P one)
           (seg* : zero* == one* [ P ↓ seg ]) → Π I P
  I-elim zero* one* seg* #zero = zero*
  I-elim zero* one* seg* #one = one*

  postulate
    I-seg-β : ∀ {i} {P : I → Type i} (zero* : P zero) (one* : P one)
              (seg* : zero* == one* [ P ↓ seg ])
              → apd (I-elim zero* one* seg*) seg == seg*

test : I → Bool
test #zero = true
test #one = false
