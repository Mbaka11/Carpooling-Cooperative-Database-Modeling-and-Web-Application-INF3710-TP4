import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { MemberPageComponent } from "../pages/member-page/member-page.component";
import { ReservationPageComponent } from "../pages/reservation-page/reservation-page.component";

import { AppComponent } from "../app.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "membres", component: MemberPageComponent },
  { path: "reservations", component: ReservationPageComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
