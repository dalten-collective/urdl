<template>
  <div class="flex-col justify-center">
    <div class="my-2 text-center">
      <input type="text" v-model="nativeKeys" id="nativeKeyInput" class="min-w-full px-2 text-center text-green-300 rounded-md bg-less-dark" placeholder="Tap here to use native keyboard" />
    </div>

    <div v-for="(row, i) in rows" :key="row[0]" style="margin: 0 auto 8px;" class="flex justify-center w-100">
      <div v-if="i == 1" style="flex: 0.5;">
      </div>

      <button v-if="i == 2" @click="sendGues" style="border-radius: 4px; height: 58px; margin: 0 6px 0 0; flex: 1.5;" class="flex items-center content-center justify-center text-sm font-bold text-center uppercase bg-gray-500 cursor-pointer norm rounded-md keyText">Enter</button>

      <button @click="appendLetter(letter)" v-for="letter in row" :key="letter" style="border-radius: 4px; height: 58px; margin: 0 6px 0 0;" class="flex items-center content-center justify-center flex-1 font-bold text-center capitalize bg-gray-500 cursor-pointer rounded-md keyText" :class="letterStyle(letter)">
        {{ letter }}
      </button>

      <button @click="popLetter" v-if="i == 2" style="border-radius: 4px; height: 58px; margin: 0 6px 0 0; flex: 1.5;" class="flex items-center content-center justify-center text-3xl font-bold text-center capitalize bg-gray-500 cursor-pointer norm rounded-md keyText">
        <span class="text-2xl">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M12 9.75L14.25 12m0 0l2.25 2.25M14.25 12l2.25-2.25M14.25 12L12 14.25m-2.58 4.92l-6.375-6.375a1.125 1.125 0 010-1.59L9.42 4.83c.211-.211.498-.33.796-.33H19.5a2.25 2.25 0 012.25 2.25v10.5a2.25 2.25 0 01-2.25 2.25h-9.284c-.298 0-.585-.119-.796-.33z" />
</svg>

        </span>
        <!--
        <svg class="del-key" xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24">
          <path d="M22 3H7c-.69 0-1.23.35-1.59.88L0 12l5.41 8.11c.36.53.9.89 1.59.89h15c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H7.07L2.4 12l4.66-7H22v14zm-11.59-2L14 13.41 17.59 17 19 15.59 15.41 12 19 8.41 17.59 7 14 10.59 10.41 7 9 8.41 12.59 12 9 15.59z"></path>
        </svg>
        -->

      </button>

      <div v-if="i == 1" style="flex: 0.5;">
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {ActionTypes} from '@/store/action-types';
import {GetterTypes} from '@/store/getter-types';
import {MutationTypes} from '@/store/mutation-types';
import { useStore } from '@/store/store'
import { ref, computed } from 'vue'

const store = useStore()

// TODO: keyboard support

const gues = computed(() => {
  return store.state.draftGuess
})

const popLetter = () => {
  store.commit(MutationTypes.DraftLetterRemove, null)
}

const appendLetter = (l) => {
  if (gues.value.length >= 5) {
    return
  }
  store.commit(MutationTypes.DraftLetterAdd, l)
}

const sendGues = () => {
  const guess = gues.value.join('')
  store.dispatch(ActionTypes.PokeGuess, guess)
}

const nativeKeys = ref('')
const rows = ref([
      [
        'q',
        'w',
        'e',
        'r',
        't',
        'y',
        'u',
        'i',
        'o',
        'p',
      ],
      [
        'a',
        's',
        'd',
        'f',
        'g',
        'h',
        'j',
        'k',
        'l',
      ],
      [
        'z',
        'x',
        'c',
        'v',
        'b',
        'n',
        'm',
        ]
])

const letterMap = computed(() => {
  return store.getters[GetterTypes.LetterMap]
})

const aGuesses = computed(() => {
  return store.getters[GetterTypes.BestColorForLetterInGuesses]('a')
})
const cGuesses = computed(() => {
  return store.getters[GetterTypes.BestColorForLetterInGuesses]('c')
})
const zGuesses = computed(() => {
  return store.getters[GetterTypes.BestColorForLetterInGuesses]('z')
})
const dGuesses = computed(() => {
  return store.getters[GetterTypes.BestColorForLetterInGuesses]('d')
})

const letterStyle = (letter) => {

const rating = store.getters[GetterTypes.BestColorForLetterInGuesses](letter)
  switch (rating) {
    case 'grey':  // miss
      return 'rong'
    case 'yellow':  // close
      return 'clos'
    case 'green':  // exact
      return 'rite'
    default:
      return 'norm'
  }
}

</script>

<style scoped>
  #nativeKeyInput::placeholder {
    color: var(--color-tone-4);
  }
  #nativeKeyInput {
    color: var(--color-tone-4);
  }
</style>
