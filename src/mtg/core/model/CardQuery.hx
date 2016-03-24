package mtg.core.model;

import dataclass.DataClass;
using thx.Arrays;
using thx.Ints;
using thx.Maps;
using thx.Strings;
using thx.Iterators;

enum TextQuery {
  ExactMatch(text : String);
  StartsWith(text : String);
  EndsWith(text : String);
  ContainsAll(text : String);
  ContainsAny(text : String);
}

enum ColorQuery {
  ExactMatch(colors : Array<Color>);
  ContainsAll(colors : Array<Color>);
  ContainsAny(colors : Array<Color>);
}

enum NumberQuery {
  Equals(value : Float);
  GreaterThan(value : Float);
  LessThan(value : Float);
  GreaterThanOrEqual(value : Float);
  LessThanOrEqual(value : Float);
  Between(low : Float, high : Float);
}

@immutable
class CardQuery implements DataClass {
  public static var QUERY = "q";
  public static var PAGE_NUMBER = "page-number";
  public static var PAGE_SIZE = "page-size";
  public static var LATEST_PRINTING_ONLY = "latest-only";

  public var pageNumber : Int = 1;

  @validate(_ <= 100)
  public var pageSize : Int = 100;

  public var searchText : String = '';

  public var latestPrintingOnly : Bool = true;

  public static function fromMap(map : Map<String, String>) : CardQuery {
    return new CardQuery({
      searchText: map.get(QUERY),
      pageNumber: stringToInt(map.get(PAGE_NUMBER)),
      pageSize: stringToInt(map.get(PAGE_SIZE)),
      latestPrintingOnly: stringToBool(map.get(LATEST_PRINTING_ONLY)),
    });
  }

  public static function fromObject(obj : {}) : CardQuery {
    var map = Reflect.fields(obj).reduce(function(acc : Map<String, String>, key) {
      var value : String = Reflect.field(obj, key);
      acc.set(key, value);
      return acc;
    }, new Map());
    return fromMap(map);
  }

  public function toQueryString() : String {
    return '$QUERY=$searchText&$PAGE_NUMBER=$pageNumber&$PAGE_SIZE=$pageSize';
  }

  static function stringToInt(input : String, ?defaultValue : Null<Int>) : Null<Int> {
    if (input.isEmpty() || !input.canParse()) return defaultValue;
    return Std.parseInt(input);
  }

  static function stringToBool(input : String, ?defaultValue : Null<Bool>) : Null<Bool> {
    if (input.isEmpty()) return defaultValue;
    return input.toLowerCase() == "true";
  }
}
