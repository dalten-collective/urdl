import { unixToDa, decToUd, udToDec } from '@urbit/api'
import * as T from '@/types'

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
