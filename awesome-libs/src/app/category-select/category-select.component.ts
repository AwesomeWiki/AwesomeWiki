import { Component, OnChanges, OnInit } from '@angular/core';
import { CategoriesService } from '../categories.service';

@Component({
  selector: 'app-category-select',
  templateUrl: './category-select.component.html',
  styleUrls: ['./category-select.component.css']
})
export class CategorySelectComponent implements OnInit {

  categories : any = [];

  constructor(
    private _categoriesService : CategoriesService
  ) { }

  ngOnInit(): void {
    var prgLang = 'test';
    this._categoriesService.prgLang$.subscribe(message => {alert(message)});
    // Upon initializing this component, subscribe to the categories service 
    this._categoriesService.getAllCategories(prgLang).subscribe( // TODO: Will passing a new language work given that this is onInit? -> may want to try implementing a different lifecycle hook
      data => this.categories = data
    );
  }

}

// This component needs to get the selected language from language-select and pass it as a parameter to getAllCategories() as a string parameter
