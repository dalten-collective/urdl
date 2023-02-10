<template>
  <div v-for="(a, i) in alow" :key="i">
    <Work v-if="i == guesCount" />
    <Rite v-else-if="riteAtIndex(a)" :rite="riteAtIndex(a).rite" :test="riteAtIndex(a).test" />
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

import Work from '@/components/Work.vue'
import Rite from '@/components/Rite.vue'

const guesCount = ref(4)
const alow = ref(6)
const how = ref({
  1: {
    rite: 'scoop', test: 'scoop'
  },
  2: {
    rite: 'scoop', test: 'boots'
  },
  3: {
    rite: 'scoop', test: 'sings'
  }
})

const riteAtIndex = (i) => {
  if (how.value.hasOwnProperty(i)) {
    return how.value[i]
  }
  return { rite: '', test: '' }
}

</script>
