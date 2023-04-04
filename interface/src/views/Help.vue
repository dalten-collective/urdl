<script setup lang="ts">
// code...
</script>

<template>
  <div id="explainer" class="container mx-auto prose prose-invert">
    <div class="flex flex-col p-2 my-4 md:p-0">

      <section>
        <h1 class="text-2xl">Urdl</h1>
        <p>
          %urdl is a daily word-guessing game where the player has six attempts to guess a five-letter word provided by the game server. The player inputs a five-letter word guess and the game indicates which letters are correct and in the correct position (marked as <span class="text-[var(--green)]">green</span>), and which letters are correct but in the wrong position (marked as <span class="text-[var(--yellow)]">yellow</span>). The player must use the feedback provided by the game to make subsequent guesses until they correctly guess the word or run out of attempts. The objective of the game is to guess the word correctly in as few attempts as possible.
        </p>
        <p>
          You only get one secret word per day! The server resets daily at midnight Pacific time and the next day's game starts two hours later. During "server downtime" the leaderboard scores are tabulated, so be sure to check back the next day to see how you're doing!
        </p>
      </section>

      <section>
        <h1 class="text-2xl">Server and Client</h1>
        <p>
          Both the secret list of words to guess and the global leaderboard are held by a game server. Everyone connected to the same server gets the same secret word each day.
        </p>
        <p>
          By default, %urdl ships with the server set to a Quartus ship. If you'd like to run your own server or point your game client to a different server, <a href="https://quartus.co" target="_blank" class="font-bold underline cursor-pointer">contact us</a> or read the source code.
        </p>
      </section>

    </div>
  </div>
</template>

<style scoped>
/* code... */
</style>
