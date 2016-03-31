package mtg.client.state;

import haxe.ds.Option;
import mtg.client.state.Page;
import thx.Nil;

class AppState {
  public var previousPage(default, null) : Option<Page>;
  public var currentPage(default, null) : Page;

  public function new() {
    this.previousPage = None;
    this.currentPage = HomePage(Loading(nil));
  }

  public function setCurrentPage(currentPage : Page) : AppState {
    this.previousPage = Some(this.currentPage);
    this.currentPage = currentPage;
    return this;
  }

  public function updateCurrentPage(currentPage : Page) : AppState {
    this.currentPage = currentPage;
    return this;
  }
}
