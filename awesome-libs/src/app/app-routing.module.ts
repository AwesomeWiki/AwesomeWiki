import { NgModule }                 from '@angular/core';
import { Routes, RouterModule }     from '@angular/router';
import { LanguageSelectComponent }  from './language-select/language-select.component'
import { CategorySelectComponent }  from './category-select/category-select.component'
import { CategoryResultsComponent } from './category-results/category-results.component'
import { ViewResultComponent }      from './view-result/view-result.component'

const routes: Routes = [
  { path: 'language-select',  component: LanguageSelectComponent },
  { path: 'category-select',  component: CategorySelectComponent },
  { path: 'category-results', component: CategoryResultsComponent },
  { path: 'view-result',      component: ViewResultComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
export const RoutingComponents = [ LanguageSelectComponent, CategorySelectComponent, CategoryResultsComponent, ViewResultComponent ]
