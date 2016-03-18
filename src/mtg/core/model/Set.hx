package mtg.core.model;

import dataclass.DataClass;

@immutable
class Set implements DataClass {
  public var name : String;
  public var code : String;
  public var gathererCode : Null<String>;
  public var oldCode : Null<String>;
  public var magicCardsInfoCode : Null<String>;
  public var releaseDate : String;
  public var border : String;
  public var type : String;
  public var block : Null<String>;
  public var onlineOnly : Bool = false;
  public var booster : Array<Dynamic> = [];

  public static function fromObject(data : {}) : Set {
    return new Set(cast data);
  }
}
