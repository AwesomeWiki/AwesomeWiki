import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, Subject } from 'rxjs';
import { ICategory } from './category';

@Injectable({
  providedIn: 'root'
})
export class CategoriesService {

  private _prgLangSource = new Subject<string>();
  prgLang$ = this._prgLangSource.asObservable();

  constructor(
    private http : HttpClient
  ) { }

  getAllCategories(prglang : string) : Observable<ICategory[]> {
    return this.http.get<ICategory[]>('/api/categories/' + prglang)
    // TODO: Add http error handling
  }

  sendMessage(message: string) {
    this._prgLangSource.next(message);
  }
}
