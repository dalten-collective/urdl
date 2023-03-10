<template>
  <div
    :style="`grid-template-columns: repeat(${spaces}, 1fr);`"
    style="display: grid; grid-gap: 5px"
  >

    <div
      v-if="noGuess"
      v-for="i in spaces"
      :key="i"
      class="inline-flex items-center justify-center font-bold capitalize align-middle rite-tile empt"
      style="font-size: 2rem"
    >
      &nbsp;
    </div>

    <div
      v-for="(outcome, index) in guess"
      :key="i"
      :class="letterStyle(outcome)"
      class="inline-flex items-center justify-center font-bold capitalize align-middle rite-tile"
      style="font-size: 2rem"
    >
      {{ outcome.letter }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";
import {GuessEntries, GuessOutcome} from "@/types/urdl";

interface Props {
  guess: GuessEntries;
}
const props = defineProps<Props>();

const spaces = ref(5);

const noGuess = computed(() => {
  if (!props.guess) {
    return true
  }
  if (Object.keys(props.guess).length > 0) {
    return false
  }
  return true
})

const letterStyle = (outcome: GuessOutcome) => {
  var style = ["border", "border-4"];
  const rating = outcome.color
  switch (rating) {
    case "grey": // miss
      style.push("rong");
      break;
    case "yellow": // close
      style.push("clos");
      break;
    case "green": // exact
      style.push("rite");
      break;
    default:
      style.push("norm");
      break;
  }
  return style;
};
</script>
