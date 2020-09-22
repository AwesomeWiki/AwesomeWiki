import { BrowserModule }                        from '@angular/platform-browser';
import { NgModule }                             from '@angular/core';

import { AppRoutingModule, RoutingComponents }  from './app-routing.module';
import { AppComponent }                         from './app.component';

import { CategoriesService } from './categories.service';

import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatButtonModule } from '@angular/material/button';

@NgModule({
  declarations: [
    AppComponent,
    RoutingComponents
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    BrowserAnimationsModule,
    MatButtonModule
  ],
  providers: [CategoriesService], // Set up dependency injection for services
  bootstrap: [AppComponent]
})
export class AppModule { }
