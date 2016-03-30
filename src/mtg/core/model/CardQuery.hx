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
  None;
}

enum ColorQuery {
  ExactMatch(colors : Array<Color>);
  ContainsAll(colors : Array<Color>);
  ContainsAny(colors : Array<Color>);
  None;
}

enum NumberQuery {
  Equals(value : Float);
  GreaterThan(value : Float);
  LessThan(value : Float);
  GreaterThanOrEqual(value : Float);
  LessThanOrEqual(value : Float);
  Between(low : Float, high : Float);
  None;
}

@immutable
class CardQuery implements DataClass {
  public static var TEXT = "text";
  public static var NAME = "name";
  public static var RULES = "rules";
  public static var FLAVOR = "flavor";
  public static var PAGE_NUMBER = "page-number";
  public static var PAGE_SIZE = "page-size";
  public static var LATEST_PRINTING_ONLY = "latest-only";

  public var pageNumber : Int = 1;
  public var pageSize : Int = 100;
  public var textQuery : TextQuery = None;
  public var nameQuery : TextQuery = None;
  public var rulesTextQuery : TextQuery = None;
  public var flavorTextQuery : TextQuery = None;
  public var latestPrintingOnly : Bool = true;
  public var powerQuery : NumberQuery = None;
  public var toughnessQuery : NumberQuery = None;
  public var cmcQuery : NumberQuery = None;
  public var colorQuery : ColorQuery = None;
  public var colorIdentityQuery : ColorQuery = None;

  public static function fromMap(map : Map<String, String>) : CardQuery {
    return new CardQuery({
      textQuery: parseTextQuery(map, TEXT),
      pageNumber: parseInt(map, PAGE_NUMBER),
      pageSize: parseInt(map, PAGE_SIZE),
      latestPrintingOnly: parseBool(map, LATEST_PRINTING_ONLY),
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
    var text = switch textQuery {
      case None : '';
      case ExactMatch(text) : '$TEXT-exact=$text';
      case StartsWith(text) : '$TEXT-starts-with=$text';
      case EndsWith(text) : '$TEXT-ends-with=$text';
      case ContainsAll(text) : '$TEXT-all=$text';
      case ContainsAny(text) : '$TEXT-any=$text';
    };
    var pageNumber = '$PAGE_NUMBER=$pageNumber';
    var pageSize = '$PAGE_SIZE=$pageSize';
    return '$text&$pageNumber&$pageSize';
  }

  static function parseInt(map : Map<String, String>, key : String, ?defaultValue : Null<Int>) : Null<Int> {
    if (!map.exists(key)) return defaultValue;
    var value = map.get(key);
    if (value.isEmpty() || !thx.Ints.canParse(value)) return defaultValue;
    return Std.parseInt(value);
  }

  static function parseBool(map : Map<String, String>, key : String, ?defaultValue : Null<Bool>) : Null<Bool> {
    if (!map.exists(key)) return defaultValue;
    var value = map.get(key);
    if (value.isEmpty() || !thx.Bools.canParse(value)) return defaultValue;
    return thx.Bools.parse(value);
  }

  static function parseTextQuery(map : Map<String, String>, key : String) : TextQuery {
    return if (map.exists('$key-exact')) ExactMatch(map.get('$key-exact'));
      else if (map.exists('$key-starts-with')) StartsWith(map.get('$key-starts-with'));
      else if (map.exists('$key-ends-with')) EndsWith(map.get('$key-ends-with'));
      else if (map.exists('$key-all')) ContainsAll(map.get('$key-all'));
      else if (map.exists('$key-any')) ContainsAny(map.get('$key-any'));
      else None;
  }
}
