<template>
  <div
    :style="`grid-template-columns: repeat(${spaces}, 1fr);`"
    style="display: grid; grid-gap: 5px"
  >
    <template v-if="!test">
      <div
        v-for="i in spaces"
        :key="i"
        class="inline-flex items-center justify-center font-bold capitalize align-middle rite-tile empt"
        style="font-size: 2rem"
      >
        &nbsp;
      </div>
    </template>

    <div
      v-for="(c, i) in test.split('')"
      :key="i"
      :class="letterStyle(i)"
      class="inline-flex items-center justify-center font-bold capitalize align-middle rite-tile"
      style="font-size: 2rem"
    >
      {{ c }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";

interface Props {
  rite: any;
  test: any;
}
const props = defineProps<Props>();

const spaces = ref(5);

const letterStyle = (index) => {
  var style = ["border", "border-4"];
  const rating = props.rite.split("")[index];
  switch (rating) {
    case "o": // miss
      style.push("rong");
      break;
    case "n": // close
      style.push("clos");
      break;
    case "x": // exact
      style.push("rite");
      break;
    default:
      style.push("norm");
      break;
  }
  return style;
};
</script>
