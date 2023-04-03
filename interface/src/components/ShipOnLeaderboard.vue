<template>
  <div>
    <span @mouseover="showTooltip = true" @touchstart="showTooltip = !showTooltip" @mouseleave="showTooltip = false" :class="donorFlair ? [donorFlair, 'cursor-pointer'] : ''" >{{ leader.player }}</span>
    <div v-if="donorLevel" class="tooltip" v-show="showTooltip">{{ tooltipMessage }}</div>
  </div>
</template>

<script setup lang="ts">
import { useStore } from "@/store/store";
import { computed, onMounted, ref, watch } from "vue";
import { LeaderboardEntry } from "@/types/urdl";

interface Props {
  leader: LeaderboardEntry;
}

const props = defineProps<Props>();

const store = useStore();

const showTooltip = ref(false);

const tooltipMessage = computed(() => {
  if (donorLevel.value === 'jule') {
    return "Jewel-tier %urdl crowdfund donor!"
  }
  if (donorLevel.value === 'gold') {
    return "Gold-tier %urdl crowdfund donor"
  }
})

const donorList = computed(() => {
  return store.state.donorList;
});

const donorLevel = computed(() => {
  if (donorList && donorList.value) {
    return donorList.value[props.leader.player] || "";
  }
  return "";
});

const donorFlair = computed(() => {
  if (donorLevel.value === 'jule') {
    return "text-[#89cff0]"
  }
  if (donorLevel.value === 'gold') {
    return "text-[#D4AF37]"
  }
  return ""
})


</script>

<style scoped>
.tooltip {
  position: absolute;
  background-color: #333;
  color: #fff;
  padding: 5px;
  border-radius: 5px;
  z-index: 1;
}
</style>
