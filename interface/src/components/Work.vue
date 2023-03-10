<template>
  <div :style="`grid-template-columns: repeat(${ spaces }, 1fr);`" style="display: grid; grid-gap: 5px;">

      <div v-for="(x, i) in spaces" :key="x"
      class="inline-flex items-center justify-center font-bold capitalize align-middle rite-tile tryy"
        style="font-size: 2rem;"
      >
        <span v-if="letterAtGuessIndex(i)">
          {{ letterAtGuessIndex(i) }}
        </span>
        <span v-else>
          &nbsp;
        </span>
      </div>
  </div>
</template>

<script setup lang="ts">
import { useStore } from '@/store/store'
import { ref, computed } from 'vue'

const store = useStore()

const gues = computed(() => {
  return store.state.draftGuess
})
const spaces = ref(5)

const letterAtGuessIndex = (i) => {
  if (gues.value.length > 0) {
    return gues.value[i]
  } else {
    return null
  }
}
</script>
