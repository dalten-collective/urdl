import * as UP from "@/api/types/urdl-user-poke"
import * as UA from "@/api/urdleActionPoker"
import * as SS from "@/api/scrier"
import * as UR from "@/api/types/urdl-user-response"

export const Pokes = {
  GuessPoke(guess) { return pokeGuessPoke(guess) }
}

export const Scries = {
  Thing() { return scryThing() }
}

function pokeGuessPoke(guess: UP.GuessPokePayload['guess']): Promise<UR.UrdlUserResponse> {
  const poker = new UA.Guess(guess)
  return poker.poke()
}

function scryThing(): Promise<R.MyAppThingResponse> {
  const scrier = new SS.ScryThing()
  return scrier.scry()
}
