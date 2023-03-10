import * as UP from "@/api/types/urdl-user-poke"
import * as UA from "@/api/urdleActionPoker"
import * as SU from "@/api/scrier-user"
import * as UR from "@/api/types/urdl-user-response"

export const Pokes = {
  GuessPoke(guess) { return pokeGuessPoke(guess) }
}

export const Scries = {
  CurrentDatGameStatus() { return scryCurrentDatGameStatus() }
}

//// Pokes

function pokeGuessPoke(guess: UP.GuessPokePayload['guess']): Promise<UR.UrdlUserResponse> {
  const poker = new UA.Guess(guess)
  return poker.poke()
}

//// Scries

function scryCurrentDatGameStatus(): Promise<UR.ScryCurrentDayGameStatus> {
  const scrier = new SU.ScryCurrentDatGameStatus()
  return scrier.scry()
}
