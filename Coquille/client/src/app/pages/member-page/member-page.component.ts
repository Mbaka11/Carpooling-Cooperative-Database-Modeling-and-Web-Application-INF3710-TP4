import { Component } from "@angular/core";
import { CommunicationService } from "../../services/communication.service";
import { Membres } from "../../../../../common/tables/Membres";

@Component({
  selector: "app-member-page",
  templateUrl: "./member-page.component.html",
  styleUrls: ["./member-page.component.css", "../../../styles.scss"],
})
export class MemberPageComponent {
  public members: Membres[] = [];
  filteredMembers: Membres[] = [];
  searchQuery: string = "";

  public constructor(
    private readonly communicationService: CommunicationService
  ) {}

  public ngOnInit(): void {
    this.communicationService.getMembres().subscribe((members: Membres[]) => {
      this.members = members.filter((member) => {
        return member.nom
          .toLowerCase()
          .includes(this.searchQuery.toLowerCase());
      });
      this.filteredMembers = this.members;
    });
  }

  onEnter(string: string) {
    this.searchQuery = string.toLowerCase();
    console.log(this.searchQuery);

    if (this.searchQuery) {
      this.filteredMembers = this.members.filter((member) => {
        return member.nom.toLowerCase().includes(this.searchQuery);
      });
    } else {
      this.filteredMembers = this.members;
    }
    console.log(this.filteredMembers);
  }
}
