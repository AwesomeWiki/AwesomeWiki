import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ICategory } from './category';

@Injectable({
  providedIn: 'root'
})
export class CategoriesService {

  constructor(private http : HttpClient) { }

  getAllCategories() : Observable<ICategory[]> {
    return this.http.get<ICategory[]>('/api/categories')
    /*
    return [
      {title : 'test title', body: 'test body'},
      {title : 'another title', body: 'another body'}
    ];
    */
  }
}
