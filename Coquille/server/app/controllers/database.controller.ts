import { Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
import Types from "../types";
import * as pg from "pg";

@injectable()
export class DatabaseController {
  public constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLÉMENTATION EST TERMINÉE
    @inject(Types.DatabaseService)
    private readonly databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();

    router.get("/membres", async (req: any, res: any) => {
      this.databaseService
        .getAllMembres()
        .then((result: pg.QueryResult) => {
          res.json(result.rows);
          console.log("Members CONTROLLER: ");
          console.log(result.rows);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
    });

    return router;
  }
}
