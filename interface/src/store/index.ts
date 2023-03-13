import { createStore as createVuexStore } from "vuex";

import ship from "@/store/ship";

export const createStore = () => {
  return createVuexStore({
    modules: {
      ship,
    },
  });
};
