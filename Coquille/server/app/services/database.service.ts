import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
// FIXME
// import { Reservation } from "../../../common/tables/Reservations";

export interface Reservation {
  idreservation: number;
  datedebut: string;
  datefin: string;
  exigences: string;
  nomembre: number;
  noimmatriculation: string;
}

@injectable()
export class DatabaseService {
  public connectionConfig: pg.ConnectionConfig = {
    user: "postgres",
    database: "TP4",
    password: "Emmerdeur2002",
    port: 5432, // Attention ! Peut aussi être 5433 pour certains utilisateurs
    host: "127.0.0.1",
    keepAlive: true,
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  public async getAllMembres(): Promise<pg.QueryResult> {
    const client: pg.PoolClient = await this.pool.connect();
    const result = await client.query(
      "SELECT * FROM Coovoiturage_schema.Membre;"
    );
    client.release();
    return result;
  }

  public async getAllReservations(): Promise<pg.QueryResult> {
    const client: pg.PoolClient = await this.pool.connect();
    const result = await client.query(
      "SELECT * FROM Coovoiturage_schema.Reservation;"
    );
    // const reservations: Reservation[] = result.rows;
    // console.log(reservations);
    client.release();
    return result;
  }

  public async createReservation(
    reservation: Reservation
  ): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (
      !reservation.idreservation ||
      !reservation.datedebut ||
      !reservation.datefin ||
      !reservation.nomembre ||
      !reservation.noimmatriculation
    ) {
      throw new Error("Missing reservation information");
    }

    if (reservation.datefin < reservation.datedebut) {
      throw new Error("La date de fin doit être après la date de début");
    }

    const allReservations = await this.getAllReservations();
    const reservations: Reservation[] = allReservations.rows;

    for (const res of reservations) {
      if (res.noimmatriculation === reservation.noimmatriculation) {
        console.log(res);
        console.log("NOIMMATRICULATION");
        console.log(res.noimmatriculation, reservation.noimmatriculation);
        const dateDebut = new Date(reservation.datedebut);
        const dateFin = new Date(reservation.datefin);
        const dateDebutRes = new Date(res.datedebut);
        const dateFinRes = new Date(res.datefin);
        console.log("DATES");
        console.log(dateDebut);
        console.log(dateFin);
        console.log("DATES RES");
        console.log(dateDebutRes);
        console.log(dateFinRes);
        if (
          // TODO: check if existing reservation overlaps with new reservation
          (dateDebutRes >= dateDebut && dateDebutRes < dateFin) ||
          (dateFinRes > dateDebut && dateFinRes <= dateFin) ||
          (dateDebutRes < dateDebut && dateFinRes > dateFin)
        ) {
          console.log("La voiture est déjà réservée pour cette période");
          console.log(res.datedebut);
          console.log(res.datefin);
          throw new Error("La voiture est déjà réservée pour cette période");
        }
      }
    }

    const values: string[] = [
      reservation.idreservation.toString(),
      reservation.datedebut.toString(),
      reservation.datefin.toString(),
      reservation.exigences,
      reservation.nomembre.toString(),
      reservation.noimmatriculation,
    ];
    const queryText: string = `INSERT INTO Coovoiturage_schema.Reservation VALUES($1,$2,$3,$4,$5,$6);`;

    const res = await client.query(queryText, values);
    client.release();
    return res;
  }
}
