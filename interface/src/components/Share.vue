<template>
  <div class="text-center">
    <div class="mb-4 text-2xl" style="line-height: 1.2em; letter-spacing: 0.15em;
      whitespace: pre;" v-html="emosToHtml"></div>
    <div>
      <textarea class="hidden" :value="copyFieldValue" ref="copyField" readonly @focus="$event.target.select()" />

      <div class="my-4">
        <button class="btn rite hover:opacity-90 hover:shadow-none" @click="copyEmos">
          share result
        </button>
      </div>

      <div v-if="showCopyNotice" class="my-4">
        <span class="text-2xl">result copied to clipboard!</span>
      </div>

      <div v-if="!showCopyNotice" class="mb-4">
        <a v-if="!copyProblems" href="#" class="underline opacity-50" @click="copyProblems = true" >help</a>
        <a v-else href="#" class="underline" @click="copyProblems = false" >thanks</a>

        <div v-if="copyProblems">
          <div>
            <p>if the share button doesn't work for you, copy this field:</p>
            <textarea id="texta" class="text-black" rows='8' :value="copyFieldValue" />
          </div>
        </div>
      </div>

    </div>
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

onMounted(() => {
  store.dispatch[ActionTypes.GetCurrentDayStats]
})

const store = useStore()

const showCopyNotice = ref(false)
const copyProblems = ref(false)

const emosToHtml = computed(() => {
  return lettersToEmojis.value.replace(/\n/g, '</br>')
})

const copyFieldValue = computed(() => {
  return `%urdl ${hoonedDate.value}\n${lettersToEmojis.value}`
})

const lettersToEmojis = computed(() => {
  const data = store.state.currentDayGameStatus

    const emojiMap = {
    "green": "🟩",
    "yellow": "🟨",
    "grey": "⬛"
  };

  let result = '';

  for (let row in data) {
    for (let col in data[row]) {
      const color = data[row][col]['color'];
      result += emojiMap[color];
    }
    result += '\n';
  }

  return result;
})

const hoonedDate = computed(() => {
       const d = new Date
       // Hoonify year (2022 => 2.022)
       const year = d.getFullYear().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
       let month = (d.getMonth() + 1)
       if (month < 10) {
         month = `0${ month }`
       }
       let day = (d.getMonth() + 1)
       if (day < 10) {
         day = `0${ day }`
       }
       return `${ year }-${ month }-${ day }`
   })

const copyEmos = () => {
  navigator.clipboard.writeText(copyFieldValue.value).then(() => {
    showCopyNotice.value = true
    setTimeout(() => {
      showCopyNotice.value = false
    }, 2500)
  }, () => {
    copyProblems.value = true
  })
}
</script>
