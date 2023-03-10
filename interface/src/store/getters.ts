import { GetterTree } from 'vuex'
import { GetterTypes } from './getter-types'
import { State } from './state'

import * as T from '@/types'
import * as L from '@/types/loading-types'
import { GuessOutcome } from '@/types/urdl'

export type Getters = {
  [GetterTypes.EXAMPLE_WITH_ARG](state: State): (arg: string) => string | null

  [GetterTypes.CurrentGuessCount](state: State): number
  [GetterTypes.LetterInGuesses](state: State): (arg: string) => Array<GuessOutcome>
  [GetterTypes.BestColorForLetterInGuesses](state: State): (arg: string) => string

  [GetterTypes.LetterMap](state: State): { [key: string]: string }

  [GetterTypes.ELEMENT_INITIAL](state: State): (uie: L.UIElement) => boolean
  [GetterTypes.ELEMENT_LOADING](state: State): (uie: L.UIElement) => boolean
  [GetterTypes.ELEMENT_SUCCESS](state: State): (uie: L.UIElement) => boolean
  [GetterTypes.ELEMENT_ERROR]  (state: State): (uie: L.UIElement) => boolean
  [GetterTypes.ELEMENT_STATUS_MAP]  (state: State, getters: Getters): (uie: L.UIElement) => L.StatusMap

  // Add more here.
}

export const getters: GetterTree<State, State> & Getters = {
  [GetterTypes.EXAMPLE_WITH_ARG]: (state) => (arg: string) => {
    // look something up in state
    return 'found it'
  },

  [GetterTypes.CurrentGuessCount]: (state): number => {
    if (Object.keys(state.currentDayGameStatus).length === 0) {
      return 0
    }
    const keys = Object.keys(state.currentDayGameStatus)
      .map(k => parseInt(k))
    return Math.max(...keys)
  },

  [GetterTypes.LetterInGuesses]: (state) => (letter: string): Array<GuessOutcome> => {
    if (Object.keys(state.currentDayGameStatus).length === 0) {
      return []
    }

    const keys = Object.keys(state.currentDayGameStatus)
    return keys.map((guessCount) => {
      const innerKeys = Object.keys(state.currentDayGameStatus[guessCount])
      return innerKeys.map((ik) => {
        const go = state.currentDayGameStatus[guessCount][ik]
        if (go.letter === letter) {
          return go.color
        }
      }).filter(color => color !== undefined)
    }).flat()
  },

  [GetterTypes.BestColorForLetterInGuesses]: (state, getters) => (letter: string): string => {
    const colors = getters.LETTER_IN_GUESSES(letter)
    if (colors.length === 0) {
      return ''
    }
    if (colors.includes('green')) {
      return 'green'
    }
    if (colors.includes('yellow')) {
      return 'yellow'
    }
    if (colors.includes('grey')) {
      return 'grey'
    }
    return ''
  },

  [GetterTypes.LetterMap]: (state): { [key: string]: string } => {
    const letters = 'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
    const letterArray = letters.split(',')
    const letterMap = {}

    letterArray.forEach((letter) => {
      const occurances = 
      letterMap[letter] = "green"
    })

    return letterMap
  },

  [GetterTypes.ELEMENT_INITIAL]: (state) => (uie: L.UIElement): boolean => {
    return state.loadingStates[uie] === L.loaderStates.initial
  },
  [GetterTypes.ELEMENT_LOADING]: (state) => (uie: L.UIElement): boolean => {
    return state.loadingStates[uie] === L.loaderStates.loading
  },
  [GetterTypes.ELEMENT_SUCCESS]: (state) => (uie: L.UIElement): boolean => {
    return state.loadingStates[uie] === L.loaderStates.success
  },
  [GetterTypes.ELEMENT_ERROR]: (state) => (uie: L.UIElement): boolean => {
    return state.loadingStates[uie] === L.loaderStates.error
  },
  [GetterTypes.ELEMENT_STATUS_MAP]: (state, getters) => (uie: L.UIElement): L.StatusMap => {
    return {
      initial: getters.ELEMENT_INITIAL(state)(uie),
      loading: getters.ELEMENT_LOADING(state)(uie),
      success: getters.ELEMENT_SUCCESS(state)(uie),
      error: getters.ELEMENT_ERROR(state)(uie),
    }
  },

  // Add more here
}
