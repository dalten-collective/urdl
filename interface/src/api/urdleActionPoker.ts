import urbitAPI from "./urbitAPI";
import * as UP from '@/api/types/urdl-user-poke'

const UrdlUserActionMark = "urdl-user-action"

class UrdlUserAction {
  payload: any;

  constructor(
    payload: UP.UrdlUserPokes
  ) {
    this.payload = payload
  }

  poke(): Promise<any> {
    const json = this.payload
    return urbitAPI.poke({
      app: 'urdl-user',
      mark: UrdlUserActionMark,
      json
    })
  }
}

export class Guess extends UrdlUserAction {
  declare payload: UP.GuessPokePayload['guess'];

  constructor(guess: UP.GuessPokePayload['guess']) {
    const json: UP.GuessPokePayload = {
      guess
    }
    super(json)
  }
}
