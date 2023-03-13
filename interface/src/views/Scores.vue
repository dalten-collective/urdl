<template>
  <main class="container flex flex-col p-2 md:mx-auto">

    <section class="mt-4 mb-8">
      <header class="flex flex-row justify-around mb-4">
        <h3 class="text-2xl">Statistics</h3>
      </header>

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
          </div>
        </div>

        <div class="flex flex-col flex-1 text-center">
          <div class="text-4xl">
            {{ myScore.streak['max-streak'] }}
          </div>
          <div>
            Max Streak
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
      Next urdl {{ Date(nextGame).toLocaleString() }}
    </section>

  <pre>
    played: {{ myScore.played }}
    win %: {{ winPercent }}%
    current streak: {{ myScore.streak['current-streak'] }}
    max streak: {{ myScore.streak['max-streak'] }}
    {{ myScore }}
  </pre>
  </main>
</template>

<script setup lang="ts">
import { useStore } from '@/store/store'
import {computed, TrackOpTypes} from 'vue';
import { GetterTypes } from '@/store/getter-types'

import { udToInt, US } from '@/helpers'
import {current} from 'immer';


const store = useStore()

const nextGame = computed(() => {
  const myDate = new Date()
  const pstDate = myDate.toLocaleString("en-US", {
    timeZone: "America/Los_Angeles"
  })
  /// const pstServerRollover = ""
  return store.state.currentTimeClose
})
const gameStarted = computed(() => {
  return store.state.currentTimeOpen
})

const myScore = computed(() => {
  return store.getters[GetterTypes.MyScores]
})

const allScores = computed(() => {
  return store.state.leaderboard
})

const winPercent = computed(() => {
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

const tryPercent = (tryCount) => {
  return Math.round((tryCount / maxTries.value) * 100)
}

const barColor = (num) => {
  // TODO: get recent game guess number from ledger
  const recentGame = 'three'

  if (recentGame === num) {
    return "rite"
    return "bg-green-700"
  }
  return "bg-[var(--color-tone-3)]"
}

const barWidth = (num) => {
  if (tryPercent(myScore.value.scores[num]) <= 5) {
    return '5%';
  }
  return `${ tryPercent(myScore.value.scores[num])}%`
}

const barText = (num) => {
  return "bg-[var(--color-tone-2)]"
}

</script>

