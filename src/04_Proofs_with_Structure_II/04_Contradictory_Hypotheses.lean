/- Copyright (c) Heather Macbeth, 2022.  All rights reserved. -/
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.ModCases
import Math2001.Library.Parity
import Math2001.Tactic.Addarith
import Math2001.Tactic.Numbers
import Math2001.Tactic.Rel

attribute [-simp] Nat.not_two_dvd_bit1 two_dvd_bit0


example {y : ℝ} (x : ℝ) (h : 0 < x * y) (hx : 0 ≤ x) : 0 < y := by
  obtain H | H : y ≤ 0 ∨ 0 < y := by apply le_or_lt
  · have : ¬0 < x * y
    · apply not_lt_of_ge
      calc
        0 = x * 0 := by ring
        _ ≥ x * y := by rel [H]
    contradiction
  exact H


def Prime (p : ℕ) : Prop :=
  2 ≤ p ∧ ∀ m : ℕ, m ∣ p → m = 1 ∨ m = p

theorem prime_test {p : ℕ} (hp : 2 ≤ p) (H : ∀ m : ℕ, 1 < m → m < p → ¬m ∣ p) : Prime p := by
  constructor
  · apply hp
  intro m hmp
  have hp' : 0 < p := by extra
  have h1m : 1 ≤ m := Nat.pos_of_dvd_of_pos hmp hp'
  obtain hm | hm_left := eq_or_lt_of_le h1m
  · left
    addarith [hm]
  sorry

example : Prime 5 := by
  apply prime_test
  · numbers
  intro m hm_left hm_right
  apply Nat.not_dvd_of_exists_lt_and_lt
  · extra
  interval_cases m
  · use 2
    constructor <;> numbers
  · use 1
    constructor <;> numbers
  · use 1
    constructor <;> numbers


example {t : ℤ} (h2 : t < 3) (h : t - 1 = 6) : t = 13 := by
  have H : (7 : ℤ) < 3
  calc
    7 = t := by addarith [h]
    _ < 3 := h2
  have : ¬(7 : ℤ) < 3 := by numbers
  contradiction


example {t : ℤ} (h2 : t < 3) (h : t - 1 = 6) : t = 13 := by
  have H : (7 : ℤ) < 3
  calc
    7 = t := by addarith [h]
    _ < 3 := h2
  numbers at H -- this is a contradiction!


example (n : ℤ) (hn : n ^ 2 + n + 1 ≡ 1 [ZMOD 3]) : n ≡ 0 [ZMOD 3] ∨ n ≡ 2 [ZMOD 3] := by
  mod_cases h : n % 3
  · -- case 1: `n ≡ 0 [ZMOD 3]`
    left
    apply h
  · -- case 2: `n ≡ 1 [ZMOD 3]`
    have H : 0 ≡ 1 [ZMOD 3]
    · calc 0 ≡ 0 + 3 * 1 [ZMOD 3] := by extra
      _ = 1 ^ 2 + 1 + 1 := by numbers
      _ ≡ n ^ 2 + n + 1 [ZMOD 3] := by rel [h.symm]
      _ ≡ 1 [ZMOD 3] := hn
    numbers at H -- contradiction!
    done
  · -- case 3: `n ≡ 2 [ZMOD 3]`
    right
    apply h


example {a b c : ℕ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (h_pyth : a ^ 2 + b ^ 2 = c ^ 2) :
    3 ≤ a := by
  sorry

example {x y : ℝ} (n : ℕ) (hx : 0 ≤ x) (hn : 0 < n) (h : y ^ n ≤ x ^ n) : y ≤ x := by
  sorry

example (n : ℤ) (hn : n ^ 2 ≡ 4 [ZMOD 5]) : n ≡ 2 [ZMOD 5] ∨ n ≡ 3 [ZMOD 5] := by
  sorry

example : Prime 7 := by
  sorry

example {x : ℚ} (h1 : x ^ 2 = 4) (h2 : 1 < x) : x = 2 := by
  have : x = 2 ∨ x + 2 = 0
  · sorry
  sorry

namespace Nat

example (p : ℕ) (h : Prime p) : p = 2 ∨ Odd p := by
  sorry