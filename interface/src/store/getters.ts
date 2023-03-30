import { GetterTree } from 'vuex'
import { GetterTypes } from './getter-types'
import { State } from './state'

import * as T from '@/types'
import * as L from '@/types/loading-types'
import { GuessOutcome, LeaderboardEntry, Ledger } from '@/types/urdl'

import { US, sumGuessCount } from '@/helpers'

export type Getters = {
  [GetterTypes.EXAMPLE_WITH_ARG](state: State): (arg: string) => string | null

  [GetterTypes.CurrentGuessCount](state: State): number
  [GetterTypes.LetterInGuesses](state: State): (arg: string) => Array<GuessOutcome>
  [GetterTypes.BestColorForLetterInGuesses](state: State): (arg: string) => string

  [GetterTypes.LetterMap](state: State): { [key: string]: string }

  [GetterTypes.MyScores](state: State): LeaderboardEntry

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

  [GetterTypes.MyScores]: (state): LeaderboardEntry => {
    const ledg = state.ledger
    const lb = state.leaderboard.find((le) => le.player === US())

    let played, curStreak, maxStreak, scores, won,
      one, two, three, four, five, six

    if (ledg) {
      played = ledg.length
    } else {
      played = 0
    }

    // TODO: how to tell if in the middle of a game?
    // Or more importantly: JUST finished a game but scores aren't computed (next day)

    if (false) {
    // if (lb) {
      curStreak = lb.streak['current-streak']
      maxStreak = lb.streak['max-streak']
      scores = lb.scores
    } else {
      curStreak = 0
      maxStreak = 0

      won = ledg.reduce((acc, curr) => {
        if (curr.outcome !== 'dnf') {
          return acc + 1
        }
        return acc
      }, 0)

      one = sumGuessCount(ledg, 'one')
      two = sumGuessCount(ledg, 'two')
      three = sumGuessCount(ledg, 'tre')
      four = sumGuessCount(ledg, 'for')
      five = sumGuessCount(ledg, 'fiv')
      six = sumGuessCount(ledg, 'six')

      scores = {
        "games-won": won,
        one,
        two,
        three,
        four,
        five,
        six,
      }
    }

    return {
      player: US(),
      played,
      streak: {
        "current-streak": curStreak,
        "max-streak": maxStreak,
      },
      scores
    }
  },

  [GetterTypes.MyLedger]: (state): Array<Ledger> => {
    return state.ledger
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
