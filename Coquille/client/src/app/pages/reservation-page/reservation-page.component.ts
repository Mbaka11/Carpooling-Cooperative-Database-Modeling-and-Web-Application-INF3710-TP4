import { Component } from "@angular/core";
import { CommunicationService } from "../../services/communication.service";
import { Reservation } from "../../../../../common/tables/Reservations";
import { ElementRef } from "@angular/core";
import { ViewChild } from "@angular/core";

@Component({
  selector: "app-reservation-page",
  templateUrl: "./reservation-page.component.html",
  styleUrls: ["./reservation-page.component.css", "../../../styles.scss"],
})
export class ReservationPageComponent {
  @ViewChild("newDateDebut") newDateDebut: ElementRef;
  @ViewChild("newDateFin") newDateFin: ElementRef;
  @ViewChild("newExigences") newExigences: ElementRef;
  @ViewChild("newNoMembre") newNomembre: ElementRef;
  @ViewChild("newNoImmatriculation") newNoimmatriculation: ElementRef;

  public reservations: Reservation[] = [];
  public duplicateError: boolean = false;

  public constructor(
    private readonly communicationService: CommunicationService
  ) {}

  public ngOnInit(): void {
    this.getReservations();
  }

  public getReservations(): void {
    this.communicationService
      .getReservations()
      .subscribe((reservations: Reservation[]) => {
        this.reservations = reservations;
      });
  }

  public getLastReservationId(): number {
    return this.reservations[this.reservations.length - 1].idreservation;
  }

  public addReservation(): void {
    const reservation: Reservation = {
      idreservation: this.getLastReservationId() + 1,
      datedebut: this.newDateDebut.nativeElement.innerText,
      datefin: this.newDateFin.nativeElement.innerText,
      exigences: this.newExigences.nativeElement.innerText,
      nomembre: this.newNomembre.nativeElement.innerText,
      noimmatriculation: this.newNoimmatriculation.nativeElement.innerText,
    };

    this.communicationService
      .insertReservation(reservation)
      .subscribe((res: number) => {
        if (res > 0) {
          this.communicationService.filter("update");
        }
        this.refresh();
        this.duplicateError = res === -1;
      });
  }

  private refresh() {
    this.getReservations();
    this.newDateDebut.nativeElement.innerText = "";
    this.newDateFin.nativeElement.innerText = "";
    this.newExigences.nativeElement.innerText = "";
    this.newNomembre.nativeElement.innerText = "";
    this.newNoimmatriculation.nativeElement.innerText = "";
  }
}
