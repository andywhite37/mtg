package mtg.core.model;

import dataclass.DataClass;

@immutable
class CardQuery implements DataClass {
  public var pageNumber : Int = 1;
  @validate(_ <= 100)
  public var pageSize : Int = 100;
  public var searchText : String = '';

  public static function fromQueryString(qs : {}) : CardQuery {
    return new CardQuery({
      searchText: Reflect.field(qs, "q"),
      pageNumber: Reflect.field(qs, "page-number"),
      pageSize: Reflect.field(qs, "page-size"),
    });
  }
}
