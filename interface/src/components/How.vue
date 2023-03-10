<template>
  <div v-for="h in how">
    <Rite :guess="h" />
  </div>

  <div v-for="(a, i) in alow" :key="i">
    <Work v-if="i == guesCount" />
    <!--
    <Rite v-else-if="riteAtIndex(a)" :rite="riteAtIndex(a).rite" :test="riteAtIndex(a).test" />
    -->
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { useStore } from '@/store/store'

import Work from '@/components/Work.vue'
import Rite from '@/components/Rite.vue'

import {GameStatus} from "@/types/urdl";

const store = useStore()


const guesCount = ref(4)
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

const riteAtIndex = (i) => {
  if (how.value.hasOwnProperty(i)) {
    return how.value[i]
  }
  return { rite: '', test: '' }
}

</script>
