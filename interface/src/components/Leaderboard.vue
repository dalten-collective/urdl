<template>
  <div class="flex items-center justify-between my-2">
    <select
      class="cursor-pointer px-3 py-3 font-bold bg-[var(--absent)] rounded-md"
      v-model="filter"
    >
      <option
        :value="opt.value"
        v-for="opt in [
          { name: 'Overall', value: 'bestWeighted' },
          { name: 'Best Streak', value: 'bestStreak' },
          { name: 'Current Streak', value: 'currentStreak' },
          { name: 'Win Rate', value: 'bestPercent' },
        ]"
      >
        {{ opt.name }}
      </option>
    </select>

    <button class="btn" @click="reverse = !reverse">
      <div v-if="!reverse">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="w-6 h-6"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M15.75 17.25L12 21m0 0l-3.75-3.75M12 21V3"
          />
        </svg>
      </div>
      <div v-else>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          class="w-6 h-6"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M8.25 6.75L12 3m0 0l3.75 3.75M12 3v18"
          />
        </svg>
      </div>
    </button>
  </div>

  <div
    class="h-[65vh] overflow-y-scroll bg-[black] rounded-md my-4 flex justify-around"
  >
    <div class="w-full">
      <div
        class="sticky top-0 p-2 bg-black shadow-md grid grid-cols-6 px-4 gap-1 border-b border-[var(--absent)]"
      >
        <div class="col-span-3 text-[var(--absent)] font-bold">Who</div>

        <div
          class="col-span-3 text-[var(--absent)] font-bold flex"
          v-if="bestWeighted"
        >
          Adjusted Performance Score
          <div class="cursor-pointer" @click="adjustedExplanation = !adjustedExplanation">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z" />
</svg>
<div class="p-4 shadow-lg tooltip" v-show="adjustedExplanation">
  The Adjusted Performance Score accounts for both the win rate and the number of guesses (fewer is better) with a special rule that discounts winning in a single guess.
</div>
          </div>

        </div>
        <div
          class="col-span-3 text-[var(--absent)] font-bold"
          v-if="bestStreak"
        >
          Best Streak
        </div>
        <div
          class="col-span-3 text-[var(--absent)] font-bold"
          v-if="currentStreak"
        >
          Current Streak
        </div>
        <div
          class="col-span-3 text-[var(--absent)] font-bold"
          v-if="bestPercent"
        >
          Win Rate
        </div>
      </div>

      <div
        v-for="leader, i in sortedLeaderboard"
        class="items-center px-4 my-1 text-lg grid grid-cols-6 gap-1"
        :class="(i % 2 === 0) ? 'bg-[var(--color-tone-6)]' : ''"
      >
        <div class="col-span-3">
          <ShipOnLeaderboard :leader="leader" />
        </div>
        <div class="col-span-3" v-if="bestStreak">
          {{ maxStreak(leader) }}
        </div>
        <div class="col-span-3" v-if="currentStreak">
          {{ playerCurrentStreak(leader) }}
        </div>
        <div class="col-span-3" v-if="bestWeighted">
          {{ weightedScore(leader) }}
          <span class="text-[var(--midGray)]"
            >({{ gamesPlayed(leader) }} played, {{ winPercent(leader) }}% won)</span
          >
        </div>
        <div class="col-span-3" v-if="bestPercent">
          {{ winPercent(leader) }}%
          <span class="text-[var(--midGray)]"
            >({{ gamesPlayed(leader) }} played)</span
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useStore } from "@/store/store";
import { computed, onMounted, ref, watch } from "vue";
import { Ship } from "@/types";
import { LeaderboardEntry } from "@/types/urdl";
import { GetterTypes } from "@/store/getter-types";
import { ActionTypes } from "@/store/action-types";

import { udToInt, US, threeLetterToScore } from "@/helpers";
import { current } from "immer";

import ShipOnLeaderboard from "@/components/ShipOnLeaderboard.vue";

const store = useStore();

const filter = ref("bestWeighted");
const reverse = ref(false);
const adjustedExplanation = ref(false);

const allScores = computed(() => {
  return store.state.leaderboard;
  // return store.state.leaderboard.concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard).concat(store.state.leaderboard)
});

watch(filter, (newVal, oldVal) => {
  reverse.value = false;
});

const sortedLeaderboard = computed(() => {
  if (bestStreak.value) {
    if (!reverse.value) {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return maxStreak(b) - maxStreak(a);
        }
      );
    } else {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return maxStreak(a) - maxStreak(b);
        }
      );
    }
  }

  if (currentStreak.value) {
    if (!reverse.value) {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return playerCurrentStreak(b) - playerCurrentStreak(a);
        }
      );
    } else {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return playerCurrentStreak(a) - playerCurrentStreak(b);
        }
      );
    }
  }

  if (bestPercent.value) {
    if (!reverse.value) {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return winPercent(b) - winPercent(a);
        }
      );
    } else {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return winPercent(a) - winPercent(b);
        }
      );
    }
  }

  if (bestWeighted.value) {
    if (!reverse.value) {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return weightedScore(b) - weightedScore(a);
        }
      );
    } else {
      return allScores.value.sort(
        (a: LeaderboardEntry, b: LeaderboardEntry) => {
          return weightedScore(a) - weightedScore(b);
        }
      );
    }
  }

  return allScores.value;
});

const bestStreak = computed(() => {
  if (filter.value === "bestStreak") {
    return true;
  }
  return false;
});
const currentStreak = computed(() => {
  if (filter.value === "currentStreak") {
    return true;
  }
  return false;
});
const bestWeighted = computed(() => {
  if (filter.value === "bestWeighted") {
    return true;
  }
  return false;
});
const bestPercent = computed(() => {
  if (filter.value === "bestPercent") {
    return true;
  }
  return false;
});

const gamesWon = (entry: LeaderboardEntry): number => {
  return entry.scores["games-won"];
};
const gamesPlayed = (entry: LeaderboardEntry): number => {
  return entry.played;
};
const winPercent = (entry: LeaderboardEntry): number => {
  const total = gamesPlayed(entry);
  const won = gamesWon(entry);
  return Math.round((won / total) * 100);
};
const maxStreak = (entry: LeaderboardEntry): number => {
  return entry.streak["max-streak"];
};
const playerCurrentStreak = (entry: LeaderboardEntry): number => {
  return entry.streak["current-streak"];
};

const customScore = (value) => {
  if (value === 1) {
    return 6;
  }
  return value;
}

const weightedScore = (entry: LeaderboardEntry): number => {
  const keyToInteger = {
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6
  };

  const exponent = 2; // Adjust this value to control the emphasis on fewer guesses

  const totalGuesses = Object.keys(entry.scores).reduce((sum, key) => {
    if (key !== "games-won" && keyToInteger[key] !== undefined) {
      const adjustedValue = customScore(keyToInteger[key])
      return sum + (parseInt(entry.scores[key]) *  Math.pow(adjustedValue, exponent));
    }
    return sum;
  }, 0);

  const totalWins = parseInt(entry.scores["games-won"]);
  const averageGuesses = totalGuesses / totalWins;
  const winRate = totalWins / parseInt(entry.played);
  const weightedAverageGuesses = averageGuesses * winRate;
  return weightedAverageGuesses.toFixed(2);
};

</script>

<style scoped>
.tooltip {
  position: absolute;
  left: 0;
  background-color: #333;
  color: #fff;
  border-radius: 5px;
  z-index: 1;
}
</style>
