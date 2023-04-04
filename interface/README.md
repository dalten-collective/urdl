# Urdl UI

Created with [Quartus's Vue3 Urbit
Template](https://github.com/vcavallo/vite-vue-urbit-template/tree/vue3-typed-store)

## Setup

- Create a `.env` file copied from `env.example` and updated to match your
environment
- Start locals fakezods: a game server and a game client running `%urdl-host`
and `%urdl-user`.
- From the root directory of the repo:
  - `bin/install-js-dependencies.sh`
  - `bin/serve-interface.sh` (if you need to point this interface at a different
  urbit port, use `VITE_URBIT_TARGET="http://localhost:yourPortHere"
  bin/serve-interface.sh` (or wherever you need to point it)
