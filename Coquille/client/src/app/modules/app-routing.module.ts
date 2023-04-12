import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { MemberPageComponent } from "../pages/member-page/member-page.component";
import { ReservationPageComponent } from "../pages/reservation-page/reservation-page.component";
import { AjoutReservationPageComponent } from "../pages/ajout-reservation-page/ajout-reservation-page.component";

import { AppComponent } from "../app.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "membres", component: MemberPageComponent },
  { path: "reservations", component: ReservationPageComponent },
  { path: "ajout-reservation", component: AjoutReservationPageComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
