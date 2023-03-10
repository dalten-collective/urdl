import * as T from '@/types'

export type GuessColor = "grey" | "green" | "yellow";
export type CurrentDay = number;
export type Outcome = "dnf" | "one" | "two" | "tre" | "for" | "fiv" | "six"

export interface Ledger {
  day: CurrentDay;
  outcome: Outcome;
  acknowledged: boolean;
}

export interface GuessOutcome {
  letter: string;
  color: GuessColor;
}

export interface GuessEntries {
  [key: string]: GuessOutcome;
}

export interface GameStatus {
  [key: string]: GuessEntries;
}
