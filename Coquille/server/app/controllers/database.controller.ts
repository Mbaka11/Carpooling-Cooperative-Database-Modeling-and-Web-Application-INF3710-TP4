import { Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
import Types from "../types";
import * as pg from "pg";
// import { Reservation } from "../../../common/tables/Reservations";
import { NextFunction, Request, Response } from "express";

export interface Reservation {
  idreservation: number;
  datedebut: string;
  datefin: string;
  exigences: string;
  nomembre: number;
  noimmatriculation: string;
}

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
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
    });

    router.get("/reservations", async (req: any, res: any) => {
      this.databaseService
        .getAllReservations()
        .then((result: pg.QueryResult) => {
          res.json(result.rows);
          console.log("Reservations CONTROLLER: ");
          console.log(result.rows);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
    });

    router.post(
      "/reservations",
      (req: Request, res: Response, _: NextFunction) => {
        if (!Object.keys(req.body).length) {
          res.status(400).send();
          return;
        }
        const reservation: Reservation = {
          idreservation: req.body.idreservation,
          datedebut: req.body.datedebut,
          datefin: req.body.datefin,
          exigences: req.body.exigences,
          nomembre: req.body.nomembre,
          noimmatriculation: req.body.noimmatriculation,
        };
        this.databaseService
          .createReservation(reservation)
          .then((result: pg.QueryResult) => {
            res.status(201).json(result.rowCount);
            console.log("Reservation créée");
            console.log(reservation);
          })
          .catch((e: Error) => {
            res.status(400).json(-1);
            console.error(e.stack);
          });
      }
    );

    return router;
  }
}
