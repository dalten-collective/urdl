<template>
  <div class="h-full mt-4">
    <div v-if="false">
      <pre>
      state: {{ testStore }}
    </pre
      >
      <input @keyup.enter="guess()" v-model="newGuess" />
      <button @click="guess()">guess</button>
    </div>

    <div v-if="!ready" class="h-full">
      <div
        v-if="overallStatus.loading"
        class="flex flex-col items-center justify-around h-[80vh] mx-auto"
      >
        <div></div>
        <div class="">
          <div role="status">
            <svg
              aria-hidden="true"
              class="w-20 h-20 mr-2 text-[var(--absent)] animate-spin fill-[var(--yellow)]"
              viewBox="0 0 100 101"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
                fill="currentColor"
              />
              <path
                d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"
                fill="currentFill"
              />
            </svg>
          </div>
          <div class="mt-4">Loading...</div>
        </div>
        <div></div>
      </div>

      <div v-else-if="!store.state.todayOpen">
        <div
          class="flex flex-col items-center justify-around h-[80vh] mx-auto"
          style="max-width: 17rem"
        >
          <div class="text-center">
            <p class="mb-4">
              The host is tabulating the leaderboard and preparing tomorrow's
              game.
            </p>
            <p>Check back soon.</p>
          </div>
        </div>
      </div>
    </div>

    <div v-else>
      <div class="m-auto" style="max-width: 17rem">
        <div
          style="display: grid; grid-gap: 5px; padding: 10px"
          :style="`grid-template-rows: repeat(${alow}, 1fr);`"
        >
          <How />
        </div>
      </div>
      <div class="container mx-auto">
        <div class="mt-4 text-center">
        </div>
        <div v-if="!todaysWord">
          <GuessBoard class="mt-4" />
        </div>

        <div
          :class="showDone ? '' : 'hidden'"
          class="fixed top-0 left-0 right-0 z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] md:h-full"
        >
          <div class="relative w-full h-full max-w-2xl mx-auto mt-12 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-[var(--midGray)] rounded-lg shadow">
              <!-- Modal header -->
              <div
                class="flex items-center justify-around p-4 border-b rounded-t border-[var(--midGray)]"
              >
                <h3 class="text-xl font-semibold text-center">
                  <span v-if="won">
                    You Won!
                  </span>
                  <span v-else>
                    Sorry...
                  </span>
                </h3>
              </div>
              <!-- Modal body -->
              <div class="p-6 text-center space-y-6">
                <span class="text-4xl">{{ todaysWord }}</span>
              </div>

              <div class="my-6">
                <Share />
              </div>

              <div
                class="flex items-center justify-end p-6 border-t border-[var(--midGray)] rounded-b space-x-2 dark:border-gray-600"
              >
                <button
                  @click="showDone = false"
                  class="btn"
                >
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { watch, onMounted, onUnmounted, computed, ref } from "vue";
import { useStore } from "@/store/store";
import { ActionTypes } from "@/store/action-types";
import { GetterTypes } from "@/store/getter-types";
import * as L from "@/types/loading-types";

import { Scries } from "@/api/urdlAPI";

import How from "@/components/How.vue";
import GuessBoard from "@/components/GuessBoard.vue";
import Share from "@/components/Share.vue";

import { initFlowbite } from 'flowbite'

const store = useStore();

const newGuess = ref("");
const alow = ref(6);
const showDone = ref(false)

onMounted(() => {
  initFlowbite();
  // const deskname = 'urdl-user'
  // startAirlock(deskname)
});

onUnmounted(() => {
  // Maybe:
  // closeAirlock()
});

const computedThings = computed(() => store.state.exampleThings);
const fromGetters = computed(() => {
  return store.getters[GetterTypes.EXAMPLE_WITH_ARG]("arg here");
});

const ready = computed(() => {
  return !overallStatus.value.loading && store.state.todayOpen;
});

const todaysWord = computed(() => {
  return store.state.todaysSecretWord
})

watch(todaysWord, (newval, oldval) => {
  if (newval) {
    showDone.value = true
  }
})

const todaysLedger = computed(() => {
  const todayLedg = store.state.ledger.find(
    (l) => parseInt(l.day) === parseInt(store.state.currentDay)
  );
  if (todayLedg && todayLedg.acknowledged) {
    return todayLedg;
  }
  return null;
});

const won = computed(() => {
  if (!todaysLedger.value) {
    return false
  }
  return todaysLedger.value.outcome !== 'dnf'
})

const overallStatus = computed(() => {
  return store.getters[GetterTypes.ELEMENT_STATUS_MAP]("overall");
});

const testStore = computed(() => {
  return store.state;
});

const guess = () => {
  store.dispatch(ActionTypes.PokeGuess, newGuess.value);
};

const startAirlock = (deskname: string) => {
  store.dispatch(ActionTypes.AIRLOCK_OPEN, deskname);
};

const closeAirlock = () => {
  // Maybe you want this.
};
</script>
