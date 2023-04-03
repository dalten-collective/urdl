import urbitAPI from "./urbitAPI";
import * as UR from "@/api/types/urdl-user-response"
import { Ship } from "@/types"
import * as Routes from "@/api/types/urdl-user-scry"
import {Ledger} from "@/types/urdl";

class MyScry {
  path: string;

  constructor(
    path: string
  ) {
    this.path = path
  }

  scry(): Promise<any> {
    const path = this.path
    return urbitAPI.scry({
      app: 'urdl-user',
      path
    })
  }
}

export class ScryCurrentDatGameStatus extends MyScry {
  constructor() {
    super(Routes.ScryEndpoints.current)
  }

  scry(): Promise<UR.ScryCurrentDayGameStatus> {
    return super.scry()
  }
}

export class ScryCurrentHost extends MyScry {
  constructor() {
    super(Routes.ScryEndpoints.host)
  }

  scry(): Promise<Ship | null> {
    return super.scry()
  }
}

export class ScryUserLedger extends MyScry {
  constructor() {
    super(Routes.ScryEndpoints.ledger)
  }

  scry(): Promise<any> {
    return super.scry()
  }
}

export class ScryLeader extends MyScry {
  constructor() {
    super(Routes.ScryEndpoints.leader)
  }

  scry(): Promise<any> {
    return super.scry()
  }
}

export class ScryWord extends MyScry {
  constructor() {
    super(Routes.ScryEndpoints.word)
  }

  scry(): Promise<any> {
    return super.scry()
  }
}
