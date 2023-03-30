import * as UP from "@/api/types/urdl-user-poke"
import * as UA from "@/api/urdleActionPoker"
import * as SU from "@/api/scrier-user"
import * as UR from "@/api/types/urdl-user-response"
import { Ship } from "@/types"
import {Ledger} from "@/types/urdl"

export const Pokes = {
  GuessPoke(guess) { return pokeGuessPoke(guess) }
}

export const Scries = {
  CurrentDatGameStatus() { return scryCurrentDatGameStatus() },
  Host() { return scryCurrentHost() },
  Ledger() { return scryUserLedger() }
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

function scryCurrentHost(): Promise<Ship | null> {
  const scrier = new SU.ScryCurrentHost()
  return scrier.scry()
}

function scryUserLedger(): Promise<any> {
  const scrier = new SU.ScryUserLedger()
  return scrier.scry()
}
