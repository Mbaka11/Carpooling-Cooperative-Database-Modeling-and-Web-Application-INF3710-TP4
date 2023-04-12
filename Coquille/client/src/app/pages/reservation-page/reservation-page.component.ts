import { Component } from "@angular/core";
import { CommunicationService } from "../../services/communication.service";
import { Reservation } from "../../../../../common/tables/Reservations";
// import { ElementRef } from "@angular/core";

@Component({
  selector: "app-reservation-page",
  templateUrl: "./reservation-page.component.html",
  styleUrls: ["./reservation-page.component.css", "../../../styles.scss"],
})
export class ReservationPageComponent {
  // @ViewChild("newDateDebut") newDateDebut: ElementRef;
  // @ViewChild("newDateFin") newDateFin: ElementRef;
  // @ViewChild("newExigences") newExigences: ElementRef;
  // @ViewChild("newNomembre") newNomembre: ElementRef;
  // @ViewChild("newNoimmatriculation") newNoimmatriculation: ElementRef;

  public reservations: Reservation[] = [];

  public constructor(
    private readonly communicationService: CommunicationService
  ) {}

  public ngOnInit(): void {
    this.communicationService
      .getReservations()
      .subscribe((reservations: Reservation[]) => {
        this.reservations = reservations;
      });
  }

  public getLastReservationId(): number {
    return this.reservations[this.reservations.length - 1].idreservation;
  }

  public TestAddReservation(): void {
    console.log("TestAddReservation");
    const dateD = new Date("2027-04-09");

    const reservation: Reservation = {
      idreservation: this.getLastReservationId() + 1,
      datedebut: dateD,
      datefin: dateD,
      // exigences: this.newExigences.nativeElement.innerText,
      exigences: "1",
      // nomembre: this.newNomembre.nativeElement.innerText,
      nomembre: 1,
      // noimmatriculation: this.newNoimmatriculation.nativeElement.innerText,
      noimmatriculation: "1",
    };

    this.communicationService.insertReservation(reservation).subscribe();
  }
}
