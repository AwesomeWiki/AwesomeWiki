import { BrowserModule }                        from '@angular/platform-browser';
import { NgModule }                             from '@angular/core';

import { AppRoutingModule, RoutingComponents }  from './app-routing.module';
import { AppComponent }                         from './app.component';

import { CategoriesService } from './categories.service';

import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    RoutingComponents
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [CategoriesService],
  bootstrap: [AppComponent]
})
export class AppModule { }
