import { Component, OnInit } from '@angular/core';
import { CategoriesService } from '../categories.service';

@Component({
  selector:     'app-language-select',
  templateUrl:  './language-select.component.html',
  styleUrls:    ['./language-select.component.css']
})
export class LanguageSelectComponent implements OnInit {

  prgLang : string;

  constructor(
    private _categoriesService : CategoriesService
  ) { }

  ngOnInit(): void {
  }

  setPrgLang() {
    alert(this.prgLang);
    //this._categoriesService.sendMessage(prgLang);
  }

}

// This component needs to pass the selected language to the category select component
