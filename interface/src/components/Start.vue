<template>
  <div>
    <div  v-if="false">
    <pre>
      state: {{ testStore }}
    </pre>
    <input @keyup.enter="guess()" v-model="newGuess" />
    <button @click="guess()">guess</button>
  </div>


    <div class="m-auto" style="max-width: 17rem;" >
      <div style="display: grid; grid-gap: 5px; padding: 10px;" :style="`grid-template-rows: repeat(${ alow }, 1fr);`">
        <How />
      </div>
    </div>
    <GuessBoard />
  </div>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, computed, ref } from 'vue';
import { useStore } from '@/store/store'
import { ActionTypes } from '@/store/action-types';
import { GetterTypes } from '@/store/getter-types';

import How from '@/components/How.vue'
import GuessBoard from '@/components/GuessBoard.vue'

const store = useStore()

const newGuess = ref('')
const alow = ref(6)

onMounted(() => {
  const deskname = 'urdl-user'
  startAirlock(deskname)
})

onUnmounted(() => {
  // Maybe:
  // closeAirlock()
})

const computedThings = computed(() => store.state.exampleThings)
const fromGetters = computed(() => {
  return store.getters[GetterTypes.EXAMPLE_WITH_ARG]('arg here');
})

const testStore = computed(() => {
  return store.state
})

const guess = () => {
  store.dispatch(ActionTypes.PokeGuess, newGuess.value)
}

const startAirlock = (deskname: string) => {
  store.dispatch(ActionTypes.AIRLOCK_OPEN, deskname)
}

const closeAirlock = () => {
  // Maybe you want this.
}
</script>


