import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";

@injectable()
export class DatabaseService {
  public connectionConfig: pg.ConnectionConfig = {
    user: "postgres",
    database: "TP4",
    password: "Coopteam4",
    port: 5432, // Attention ! Peut aussi être 5433 pour certains utilisateurs
    host: "127.0.0.1",
    keepAlive: true,
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  // public async getAllMembres(): Promise<any> {
  //   const client: pg.PoolClient = await this.pool.connect();
  //   const result = await client.query(
  //     "SELECT * FROM Coovoiturage_schema.Membre"
  //   );
  //   client.release();
  //   console.log(result.rows);
  //   return result.rows;
  // }

  public async getAllMembres(): Promise<pg.QueryResult> {
    const client: pg.PoolClient = await this.pool.connect();
    const result = await client.query(
      "SELECT * FROM Coovoiturage_schema.Membre;"
    );
    client.release();
    console.log(result);
    return result;
  }
}
