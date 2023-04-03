import urbitAPI from "./urbitAPI";
import * as UR from "@/api/types/urdl-user-response"
import * as Routes from "@/api/types/urdl-user-scry"

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
      app: 'urdl',
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
