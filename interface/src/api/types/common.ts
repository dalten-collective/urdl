import * as UUR from '@/api/types/urdl-user-response'

export enum ResponseTypes {
  Scry = "SCRY",
  Fact = "FACT"
}
export type ResponseType = keyof typeof ResponseTypes

export type GallResponse =
  UUR.UrdlUserResponse

export const IsUrdlUserGuessResponse = (r: UUR.UrdlUserResponse):
  r is UUR.FactGuessResult => {
  return (r.face === UUR.UrdlUserResponseFaces.GuessResult)
}

export const IsNoHostResponse = (r: UUR.UrdlUserResponse):
  r is UUR.ScryNoHost => {
  return (r.face === UUR.UrdlUserResponseFaces.NoHost)
}

export const IsCurrentHost = (r: UUR.UrdlUserResponse):
  r is UUR.ScryCurrentHost => {
  return (r.face === UUR.UrdlUserResponseFaces.CurrentHost)
}

export const IsCurrentDay = (r: UUR.UrdlUserResponse):
  r is UUR.ScryCurrentDay => {
  return (r.face === UUR.UrdlUserResponseFaces.CurrentDay)
}

export const IsOpen = (r: UUR.UrdlUserResponse):
  r is UUR.ScryOpen => {
  return (r.face === UUR.UrdlUserResponseFaces.Open)
}

export const IsUserLedger = (r: UUR.UrdlUserResponse):
  r is UUR.ScryUserLedger => {
  return (r.face === UUR.UrdlUserResponseFaces.UserLedger)
}

export const IsAllowedWords = (r: UUR.UrdlUserResponse):
  r is UUR.ScryAllowedWords => {
  return (r.face === UUR.UrdlUserResponseFaces.AllowedWords)
}

export const IsSecretWordUnknown = (r: UUR.UrdlUserResponse):
  r is UUR.ScrySecretWord => {
  return (r.face === UUR.UrdlUserResponseFaces.SecretWordUnknown)
}

export const IsSecretWordFound = (r: UUR.UrdlUserResponse):
  r is UUR.ScrySecretWord => {
  return (r.face === UUR.UrdlUserResponseFaces.SecretWordFound)
}

export const IsCurrentDayGameStatus = (r: UUR.UrdlUserResponse):
  r is UUR.ScryCurrentDayGameStatus => {
  return (r.face === UUR.UrdlUserResponseFaces.CurrentDayGameStatus)
}
