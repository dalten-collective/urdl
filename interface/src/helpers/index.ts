import { unixToDa, decToUd, udToDec } from '@urbit/api'
import * as T from '@/types'
import * as U from '@/types/urdl'

export const sigShip = (ship: string | T.Ship): T.Ship => {
  if (!ship) {
    return '~'
  }
  if (ship[0] === "~") {
    return ship as T.Ship;
  }
  return `~${ship}`;
}

export const US = (): T.Ship => {
  return sigShip(window.ship)
}

export const nowToUd = (): string => {
  return decToUd(unixToDa(Date.now()).toString())
}

export const secondsToUd = (sects: number): string => {
  return decToUd(unixToDa(sects).toString())
}

export const udToInt = (n: string): number => {
  return parseInt(udToDec(n))
}

export const sumGuessCount = (ledger: Array<U.Ledger>, guessCount: string): number => {
  return ledger.reduce((acc, curr) => {
    if (curr.outcome === guessCount) {
      return acc + 1
    }
    return acc
  }, 0)
}

export const threeLetterToScore = (threeLetter: string): string => {
  switch (threeLetter) {
    case 'tre':
      return 'three'
    case 'for':
      return 'four'
    case 'fiv':
      return 'five'
    default:
      return threeLetter
  }
}
