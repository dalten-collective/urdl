<template>
  <div v-for="(a, i) in alow" :key="i">
    <Work v-if="i == guesCount" />
    <Rite v-else-if="guessAtIndex(a)" :guess="guessAtIndex(a)" />
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { useStore } from '@/store/store'
import { GetterTypes } from '@/store/getter-types'

import Work from '@/components/Work.vue'
import Rite from '@/components/Rite.vue'

import {GameStatus} from "@/types/urdl";

const store = useStore()


const guesCount = computed(() => {
  return store.getters[GetterTypes.CurrentGuessCount]
})
const alow = ref(6)

const gameStatus = computed(() => {
  return store.state.currentDayGameStatus
})

const how = computed(() => {
  const keys = Object.keys(gameStatus.value)
  return keys.map((k: string) => {
    return gameStatus.value[k]
  })
})

// const how = ref({
//   1: {
//     rite: 'scoop', test: 'scoop'
//   },
//   2: {
//     rite: 'scoop', test: 'boots'
//   },
//   3: {
//     rite: 'scoop', test: 'sings'
//   }
// })

const guessAtIndex = (i) => {
  const keys = Object.keys(gameStatus.value).map(k => parseInt(k))
  if (keys.includes(i)) {
    return gameStatus.value[i]
  }
  return {}
}

</script>
