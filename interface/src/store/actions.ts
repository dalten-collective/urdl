import { ActionTree, ActionContext, DispatchOptions } from "vuex";
import { State } from "./state";
import { Getters } from "./getters";
import { Mutations } from "./mutations";
import { ActionTypes } from "./action-types";
import { MutationTypes } from "./mutation-types";

import * as T from "@/types";
import * as L from "@/types/loading-types";
import * as Api from "@/api/types/common";

import airlock from "@/api";

type AugmentedActionContext = {
  commit<K extends keyof Mutations>(
    key: K,
    payload: Parameters<Mutations[K]>[1]
  ): ReturnType<Mutations[K]>;
  getters: {
    [K in keyof Getters]: ReturnType<Getters[K]>;
  };
  dispatch<K extends keyof Actions>(
    key: K,
    payload?: Parameters<Actions[K]>[1],
    options?: DispatchOptions
  ): ReturnType<Actions[K]>;
} & Omit<ActionContext<State, State>, "commit">;

export interface Actions {
  [ActionTypes.EXAMPLE](
    { commit }: AugmentedActionContext,
    payload: string
  ): void;

  [ActionTypes.LOADING_STATE_RESET](
    { commit }: AugmentedActionContext,
    payload: L.UIElement
  ): void;
  [ActionTypes.INITIAL_SET](
    { commit }: AugmentedActionContext,
    payload: L.UIElement
  ): void;
  [ActionTypes.LOADING_SET](
    { commit }: AugmentedActionContext,
    payload: L.UIElement
  ): void;
  [ActionTypes.SUCCESS_SET](
    { commit }: AugmentedActionContext,
    payload: L.UIElement
  ): void;
  [ActionTypes.ERROR_SET](
    { commit }: AugmentedActionContext,
    payload: L.UIElement
  ): void;

  // Add more here.
}

export const actions: ActionTree<State, State> & Actions = {
  [ActionTypes.AIRLOCK_OPEN]({ commit, dispatch }, deskName: string) {
    airlock.openAirlockTo(
      deskName,

      // Main all-responses-handler
      (data: Api.GallResponse) => {
        if (Api.IsCurrentHost(data)) {
          commit(MutationTypes.CurrentHostSet, data.fact);
        }

        if (Api.IsCurrentDay(data)) {
          commit(MutationTypes.CurrentDaySet, data.fact);
        }

        if (Api.IsCurrentDayGameStatus(data)) {
          commit(MutationTypes.CurrentDayGameStatusSet, data.fact);
        }

        if (Api.IsUserLedger(data)) {
          commit(MutationTypes.LedgerSet, data.fact);
        }

        if (Api.IsSecretWordFound(data) || Api.IsSecretWordUnknown(data)) {
          commit(MutationTypes.SecretWordSet, data.fact);
        }

        if (Api.IsOpen(data)) {
          commit(MutationTypes.TodayOpenSet, data.fact);
        }
      },

      (subscriptionNumber: number) => {
        // Thing to do on subscription callback, if anything
      }
    );
  },

  [ActionTypes.EXAMPLE]({ commit, getters }, payload: string) {
    console.log("dispatching EXAMPLE action...");
    console.log("getters ", getters); // Access to getters
    commit(MutationTypes.EXAMPLE, "test");
  },

  [ActionTypes.INITIAL_SET]({ commit }, payload: L.UIElement) {
    const currentState: L.LoaderState = L.loaderStates.initial;
    commit(MutationTypes.LOADING_STATE_SET, {
      uiElement: payload,
      currentState,
    });
  },

  [ActionTypes.LOADING_SET]({ commit }, payload: L.UIElement) {
    const currentState: L.LoaderState = L.loaderStates.loading;
    commit(MutationTypes.LOADING_STATE_SET, {
      uiElement: payload,
      currentState,
    });
  },

  [ActionTypes.SUCCESS_SET](
    { commit, dispatch },
    payload: L.UIElement
  ) {
    const currentState: L.LoaderState = L.loaderStates.success;
    commit(MutationTypes.LOADING_STATE_SET, {
      uiElement: payload,
      currentState,
    });
    dispatch(ActionTypes.LOADING_STATE_RESET, payload);
  },

  [ActionTypes.ERROR_SET]({ commit }, payload: L.UIElement) {
    const currentState: L.LoaderState = L.loaderStates.error;
    commit(MutationTypes.LOADING_STATE_SET, {
      uiElement: payload,
      currentState,
    });
  },

  [ActionTypes.LOADING_STATE_RESET](ctx, payload: L.UIElement) {
    setTimeout(() => {
      ctx.dispatch(ActionTypes.INITIAL_SET, payload);
    }, 3000);
  },

  // Add more here
};
