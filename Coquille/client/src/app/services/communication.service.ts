// À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable, Subject } from "rxjs";
import { of } from "rxjs";
import { catchError } from "rxjs/operators";

import { Membres } from "../../../../common/tables/Membres";
import { Reservation } from "../../../../common/tables/Reservations";

@Injectable()
export class CommunicationService {
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private readonly BASE_URL: string = "http://localhost:4000/database";
  public constructor(private readonly http: HttpClient) {}

  private _listeners: any = new Subject<any>();

  listen(): Observable<any> {
    return this._listeners.asObservable();
  }

  filter(filterBy: string): void {
    this._listeners.next(filterBy);
  }

  public getMembres(): Observable<Membres[]> {
    return this.http
      .get<Membres[]>(this.BASE_URL + "/membres")
      .pipe(catchError(this.handleError<Membres[]>("getMembres")));
  }

  public getReservations(): Observable<Reservation[]> {
    return this.http
      .get<Reservation[]>(this.BASE_URL + "/reservations")
      .pipe(catchError(this.handleError<Reservation[]>("getReservations")));
  }

  public insertReservation(reservation: Reservation): Observable<number> {
    return this.http
      .post<number>(this.BASE_URL + "/reservations", reservation)
      .pipe(catchError(this.handleError<number>("insertReservation")));
  }

  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private handleError<T>(
    request: string,
    result?: T
  ): (error: Error) => Observable<T> {
    return (error: Error): Observable<T> => {
      return of(result as T);
    };
  }
}
