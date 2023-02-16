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

export interface FactGuessResult {
  type: Api.ResponseTypes.Fact;
  face: UrdlUserResponseFaces.GuessResult;
  fact: {
    0: U.GuessOutcome;
    1: U.GuessOutcome;
    2: U.GuessOutcome;
    3: U.GuessOutcome;
    4: U.GuessOutcome;
  };
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
  | ScryCurrentDayGameStatus;
