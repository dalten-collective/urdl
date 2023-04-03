<template>
  <div v-if="overallStatus.loading" class="flex flex-col items-center justify-around h-[80vh] mx-auto">
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
      <div class="mt-4">
      Loading...
    </div>
    </div>
    <div></div>
  </div>

  <div v-else>
  <main class="container flex flex-col p-2 md:mx-auto">

    <nav class="flex flex-row justify-around mb-4">
      <h3 class="text-2xl cursor-pointer" @click="viewStats" :class="viewingStats ? 'underline' : 'opacity-50'">My Stats</h3>
      <h3 class="text-2xl cursor-pointer" @click="viewLeaderboard" :class="!viewingStats ? 'underline' : 'opacity-50'">Leaderboard</h3>
    </nav>

    <div v-if="viewingStats">
      <div v-if="myLedger">

      <section class="mt-4 mb-8">

        <div class="flex flex-row justify-between md:justify-around">
          <div class="flex flex-col flex-1 text-center">
            <div class="text-4xl">
              {{ myScore.played }}
            </div>
            <div>
              Played
            </div>
          </div>

          <div class="flex flex-col flex-1 text-center">
            <div class="text-4xl">
              {{winPercent}}%
            </div>
            <div>
              Win %
            </div>
            <div>
              ({{ myScore.scores['games-won'] }} won)
            </div>
          </div>

          <div class="flex flex-col flex-1 text-center">
            <div class="text-4xl">
              {{ myScore.streak['current-streak'] }}
            </div>
            <div>
              Current Streak
              <div v-if="gameFinished">
                (check back tomorrow)
              </div>
            </div>
          </div>

          <div class="flex flex-col flex-1 text-center">
            <div class="text-4xl">
              {{ myScore.streak['max-streak'] }}
            </div>
            <div>
              Max Streak
              <div v-if="gameFinished">
                (check back tomorrow)
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="mt-4 mb-8">
        <header class="flex flex-row justify-around mb-4">
          <h3 class="text-3xl">Guess Distribution</h3>
        </header>

        <div class="flex flex-col justify-between">
          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              1
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('one') }"
                :class="[barWidth('one'), barText('one'), barColor('one')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['one'] }}
              </div>
            </div>
          </div>

          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              2
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('two') }"
                :class="[barWidth('two'), barText('two'), barColor('two')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['two'] }}
              </div>
            </div>
          </div>

          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              3
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('three') }"
                :class="[barWidth('three'), barText('three'), barColor('three')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['three'] }}
              </div>
            </div>
          </div>

          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              4
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('four') }"
                :class="[barWidth('four'), barText('four'), barColor('four')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['four'] }}
              </div>
            </div>
          </div>

          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              5
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('five') }"
                :class="[barWidth('five'), barText('five'), barColor('five')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['five'] }}
              </div>
            </div>
          </div>

          <div class="flex flex-row items-center flex-1 mb-2 text-center">
            <div class="pr-2 text-2xl">
              6
            </div>
            <div class="w-full">
              <div
                :style="{ width: barWidth('six') }"
                :class="[barWidth('six'), barText('six'), barColor('six')]"
                class="items-center h-full px-2 text-2xl font-bold text-right">
                {{ myScore.scores['six'] }}
              </div>
            </div>
          </div>

        </div>
      </section>

      <section class="mt-4 mb-8">
        <div class="flex flex-row">

          <div class="flex flex-col flex-1 text-center">
            <div>
              <h3 class="text-3xl">
                Game Ends
              </h3>
            </div>
            <div class="text-4xl">
              {{ countdownEnd.hours }}:{{ countdownEnd.minutes }}:{{ countdownEnd.seconds }}
            </div>
          </div>

          <div class="flex flex-col flex-1 text-center">
            <div>
              <h3 class="text-3xl">
                Next Urdl
              </h3>
            </div>
            <div class="text-4xl">
              {{ countdownNext.hours }}:{{ countdownNext.minutes }}:{{ countdownNext.seconds }}
            </div>
          </div>
        </div>
      </section>
    </div>

    <div v-else>
      No games played!
    </div>
  </div> <!-- my stats -->

  <div v-if="!viewingStats">
    <Leaderboard />
  </div>

  </main>
  </div>
</template>

<script setup lang="ts">
import { useStore } from '@/store/store'
import {computed, onMounted, ref} from 'vue';
import { GetterTypes } from '@/store/getter-types'
import { ActionTypes } from '@/store/action-types'

import { udToInt, US, threeLetterToScore } from '@/helpers'
import {current} from 'immer';

import Leaderboard from '@/components/Leaderboard.vue'

const store = useStore()

const countdownEnd = ref({})
const countdownNext = ref({})
const viewingStats = ref(true)

onMounted(() => {
  getLeaderboard()
  setInterval(() => {
    countdownEnd.value = countdown(gameEnd.value)
    countdownNext.value = countdown(nextGame.value)
  }, 1000)
})

const gameFinished = computed(() => {
  return store.getters[GetterTypes.IsGameFinished]
})

const gameEnd = computed(() => {
  const clos = new Date(store.state.currentTimeClose * 1000)
  return new Date(clos)
})

const nextGame = computed(() => {
  const clos = new Date(store.state.currentTimeClose * 1000)
  const op = clos.setHours(clos.getHours() + 2) // 2 hours, not 1.5
  return new Date(op)
})

const overallStatus = computed(() => {
  return store.getters[GetterTypes.ELEMENT_STATUS_MAP]("overall");
});

// TODO
// deal with dead time.
// next open is open

const countdown = (until) => {
  const compare = until
  var now = new Date()
  var diff = compare.getTime() - now.getTime()
  var sec = Math.floor(diff / 1000);
  var min = Math.floor(sec / 60);
  var hou = Math.floor(min / 60);
  hou %= 24
  min %= 60
  sec %= 60
  const hours = ('0'+hou).slice(-2);
  const minutes = ('0'+min).slice(-2);
  const seconds = ('0'+sec).slice(-2);
  return {
    hours, minutes, seconds
  }
}

const gameStarted = computed(() => {
  return store.state.currentTimeOpen
})

const myScore = computed(() => {
  return store.getters[GetterTypes.MyScores]
})

const myLedger = computed(() => {
  return store.getters[GetterTypes.MyLedger]
})

const winPercent = computed(() => {
  if (myScore.value.played === 0) {
    return 0
  }

  const total = myScore.value.played 
  const won = myScore.value.scores['games-won']
  return Math.round((won / total) * 100)
})

const maxTries = computed(() => {
  return Math.max(...[
    myScore.value.scores.one,
    myScore.value.scores.two,
    myScore.value.scores.three,
    myScore.value.scores.four,
    myScore.value.scores.five,
    myScore.value.scores.six,
  ])
})


const getLeaderboard = () => {
  store.dispatch(ActionTypes.ScryLeaderboard)
}

const viewLeaderboard = () => {
  viewingStats.value = false
}

const viewStats = () => {
  viewingStats.value = true
}

const tryPercent = (tryCount) => {
  if (maxTries.value === 0) {
    return 0
  }
  return Math.round((tryCount / maxTries.value) * 100)
}

const barColor = (num) => {
  // TODO: get recent game guess number from ledger
  let recentGame = 'dnf'
  if (myLedger.value && myLedger.value.length > 0) {
    const lastDay = myLedger.value.reduce((prev, curr) => {
      return parseInt(curr.day) > parseInt(prev.day) ? curr : prev;
    })
    recentGame = threeLetterToScore(lastDay.outcome)
  }

  if (recentGame === num) {
    return "rite"
  }
  return "bg-[var(--color-tone-3)]"
}

const barWidth = (num) => {
  if (tryPercent(myScore.value.scores[num]) <= 5) {
    return '26px';
  }
  return `${ tryPercent(myScore.value.scores[num])}%`
}

const barText = (num) => {
  return "bg-[var(--color-tone-2)]"
}

</script>

