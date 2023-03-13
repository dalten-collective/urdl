import * as T from "@/types";
import * as U from "@/types/urdl";
import * as L from "@/types/loading-types";

import { loaderStates } from "@/types/loading-types";

const uiElementLoadingState: L.UILoaderState = {
  yourElementHere: loaderStates.initial,
  anotherElement: loaderStates.initial,
}

export const state = {
  currentHost: '' as T.Ship,
  currentDay: 0 as U.CurrentDay,
  currentDayGameStatus: {} as U.GameStatus,
  currentTimeOpen: 0 as number,
  currentTimeClose: 0 as number,
  draftGuess: [] as Array<string>,
  ledger: [] as Array<U.Ledger>,
  todaysSecretWord: null as string | null,
  todayOpen: false as boolean,
  leaderboard: [
    {
      "player": "~dev",
      "played": 24,
      "streak": {"current-streak": 0, "max-streak": 3},
      "scores": {
        "games-won": 10,
        "one": 1,
        "two": 0,
        "three": 5,
        "four": 4,
        "five": 0,
        "six": 0
      }
    }
  ] as Array<U.LeaderboardEntry>,

  loadingStates: uiElementLoadingState as L.UILoaderState,
}

export type State = typeof state
