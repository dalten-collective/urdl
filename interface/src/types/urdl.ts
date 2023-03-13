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

export interface LeaderboardEntry {
  player: T.Ship;
  played: number;
  streak: {
    'current-streak': number;
    'max-streak': number;
  };
  scores: {
    'games-won': number;
    'one': number;
    'two': number;
    'three': number;
    'four': number;
    'five': number;
    'six': number;
  };
}
