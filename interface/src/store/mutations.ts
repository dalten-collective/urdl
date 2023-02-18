import { MutationTree } from "vuex";
import { MutationTypes } from "./mutation-types";
import { State } from "./state";
import * as T from "@/types";
import * as U from "@/types/urdl";
import * as L from "@/loading-types";
import { sigShip } from "@/helpers"

export type Mutations<S = State> = {
  [MutationTypes.EXAMPLE](
    state: S,
    payload: string
  ): void;

  [MutationTypes.CurrentHostSet](
    state: S,
    payload: T.Ship
  ): void;

  [MutationTypes.CurrentDaySet](
    state: S,
    payload: U.CurrentDay
  ): void;

  [MutationTypes.CurrentDayGameStatusSet](
    state: S,
    payload: U.GuessOutcome
  ): void;

  [MutationTypes.LedgerSet](
    state: S,
    payload: Array<U.Ledger>
  ): void;

  [MutationTypes.SecretWordSet](
    state: S,
    payload: null | string
  ): void;

  [MutationTypes.TodayOpenSet](
    state: S,
    payload: boolean
  ): void;

  [MutationTypes.CurrentTimeOpenSet](
    state: S,
    payload: number
  ): void;
  [MutationTypes.CurrentTimeCloseSet](
    state: S,
    payload: number
  ): void;

  [MutationTypes.LOADING_STATE_SET](
    state: S,
    payload: { uiElement: L.UIElement, currentState: L.LoaderState }
  ): void;

  // Add more here
};

export const mutations: MutationTree<State> & Mutations = {
  [MutationTypes.EXAMPLE](
    state,
    payload: string
  ) {
    // update state
    // state.somethign = payload
  },

  [MutationTypes.CurrentHostSet](
    state,
    payload: Parameters<Mutations[MutationTypes.CurrentHostSet]>[1]
  ) {
    state.currentHost = payload
  },

  [MutationTypes.CurrentDaySet](
    state,
    payload: Parameters<Mutations[MutationTypes.CurrentDaySet]>[1]
  ) {
    state.currentDay = payload
  },

  [MutationTypes.CurrentDayGameStatusSet](
    state,
    payload: Parameters<Mutations[MutationTypes.CurrentDayGameStatusSet]>[1]
  ) {
    state.currentDayGameStatus = payload
  },

  [MutationTypes.LedgerSet](
    state,
    payload: Parameters<Mutations[MutationTypes.LedgerSet]>[1]
  ) {
    state.ledger = payload
  },

  [MutationTypes.SecretWordSet](
    state,
    payload: Parameters<Mutations[MutationTypes.SecretWordSet]>[1]
  ) {
    state.todaysSecretWord = payload
  },

  [MutationTypes.TodayOpenSet](
    state,
    payload: Parameters<Mutations[MutationTypes.TodayOpenSet]>[1]
  ) {
    state.todayOpen = payload
  },

  [MutationTypes.CurrentTimeOpenSet](
    state,
    payload: Parameters<Mutations[MutationTypes.CurrentTimeOpenSet]>[1]
  ) {
    state.currentTimeOpen = payload
  },
  [MutationTypes.CurrentTimeCloseSet](
    state,
    payload: Parameters<Mutations[MutationTypes.CurrentTimeCloseSet]>[1]
  ) {
    state.currentTimeClose = payload
  },

  [MutationTypes.LOADING_STATE_SET](
    state,
    payload: { uiElement: L.UIElement, currentState: L.LoaderState }
  ) {
    state.loadingStates[payload.uiElement] = payload.currentState
  },

  // Add more here
};
