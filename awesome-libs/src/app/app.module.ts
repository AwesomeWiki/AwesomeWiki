import { BrowserModule }                        from '@angular/platform-browser';
import { NgModule }                             from '@angular/core';

import { AppRoutingModule, RoutingComponents }  from './app-routing.module';
import { AppComponent }                         from './app.component';

@NgModule({
  declarations: [
    AppComponent,
    RoutingComponents
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
