import * as T from "@/types";
import * as U from "@/types/urdl";
import * as Api from "@/api/types/common";

export enum UrdlUserResponseFaces {
  GuessResult = "GUESS-RESULT",
  NoHost = "NO-HOST-SET",
  CurrentHost = "CURRENT-HOST",
  CurrentDay = "CURRENT-DAY",
  UserLedger = "USER-LEDGER",
  Open = "OPEN",
  AllowedWords = "ALLOWED-WORDS",
  SecretWordUnknown = "SECRET-WORD-UNKNOWN",
  SecretWordFound = "SECRET-WORD-FOUND",
  CurrentDayGameStatus = "CURRENT-DAY-GAME-STATUS",
  CurrentTimeLimits = "CURRENT-TIME-LIMITS",
  Leaderboard = "LEADERBOARD",
  PaidDonors = "PAID-DONORS",
}

export interface ScryNoHost {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.NoHost;
  fact: null;
}

export interface ScryCurrentHost {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.CurrentHost;
  fact: { host: T.Ship };
}

export interface ScryPaidDonors {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.PaidDonors;
  fact: {
    [key: T.Ship]: "gold" | "jule";
  }
}

export interface ScryCurrentDay {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.CurrentDay;
  fact: U.CurrentDay;
}

export interface ScryUserLedger {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.UserLedger;
  fact: Array<U.Ledger>;
}

export interface ScryOpen {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.Open;
  fact: boolean;
}

export interface ScryAllowedWords {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.AllowedWords;
  fact: Array<string>;
  // all possible 5-letter words, for checking pre-guess client-side
}

export interface ScrySecretWord {
  type: Api.ResponseTypes.Scry;
  face:
    | UrdlUserResponseFaces.SecretWordFound
    | UrdlUserResponseFaces.SecretWordUnknown;
  fact: string | null; // the discovered word | not yet discovered
}

export interface ScryCurrentDayGameStatus {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.CurrentDayGameStatus;
  fact: {
    [key: number]: {
      0: U.GuessOutcome;
      1: U.GuessOutcome;
      2: U.GuessOutcome;
      3: U.GuessOutcome;
      4: U.GuessOutcome;
    };
  };
}

export interface ScryCurrentTimeLimits {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.CurrentTimeLimits
  fact: {
    close: number;
    open: number;
  }
}

export interface FactGuessResult {
  type: Api.ResponseTypes.Fact;
  face: UrdlUserResponseFaces.GuessResult;
  fact: {
    1: U.GuessOutcome;
    2: U.GuessOutcome;
    3: U.GuessOutcome;
    4: U.GuessOutcome;
    5: U.GuessOutcome;
  };
}

export interface ScryLeaderboard {
  type: Api.ResponseTypes.Scry;
  face: UrdlUserResponseFaces.Leaderboard;
  fact: Array<U.LeaderboardEntry>;
}

export type UrdlUserResponse =
  | FactGuessResult
  | ScryNoHost
  | ScryCurrentHost
  | ScryCurrentDay
  | ScryOpen
  | ScryUserLedger
  | ScryAllowedWords
  | ScrySecretWord
  | ScryCurrentDayGameStatus
  | ScryCurrentTimeLimits
  | ScryLeaderboard
  | ScryPaidDonors;
