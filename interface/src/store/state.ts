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

  loadingStates: uiElementLoadingState as L.UILoaderState,
}

export type State = typeof state
