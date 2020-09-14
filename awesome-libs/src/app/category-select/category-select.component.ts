import { Component, OnInit } from '@angular/core';
import { CategoriesService } from '../categories.service';

@Component({
  selector: 'app-category-select',
  templateUrl: './category-select.component.html',
  styleUrls: ['./category-select.component.css']
})
export class CategorySelectComponent implements OnInit {

  categories : any = [];

  constructor(private _categoriesService : CategoriesService) { }

  ngOnInit(): void {
    this._categoriesService.getAllCategories().subscribe(data => this.categories = data);
  }

}
