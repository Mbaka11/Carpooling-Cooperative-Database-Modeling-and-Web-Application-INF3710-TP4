import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AjoutReservationPageComponent } from './ajout-reservation-page.component';

describe('AjoutReservationPageComponent', () => {
  let component: AjoutReservationPageComponent;
  let fixture: ComponentFixture<AjoutReservationPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AjoutReservationPageComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AjoutReservationPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
