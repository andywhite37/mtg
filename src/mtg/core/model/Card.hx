package mtg.core.model;

import dataclass.DataClass;
using thx.Arrays;
using mtg.core.util.Arrays;

@immutable
class Card implements DataClass {
  // mtgjson fields
  public var id : String;
  public var layout : String;
  public var name : String;
  public var names : Array<String> = [];
  public var manaCost : Null<String>;
  public var cmc : Int = 0;
  public var colors : Array<String> = [];
  public var colorIdentity : Array<String> = [];
  public var type : String;
  public var supertypes : Array<String> = [];
  public var types : Array<String> = [];
  public var subtypes : Array<String> = [];
  public var rarity : String;
  public var text : Null<String>;
  public var flavor : Null<String>;
  public var artist : Null<String>;
  public var number : Null<String>;
  public var mciNumber : Null<String>;
  public var power : Null<String>;
  public var toughness : Null<String>;
  public var loyalty : Null<Int>;
  public var multiverseid : Int;
  public var variations : Array<Int> = [];
  public var imageName : String;
  public var watermark : Null<String>;
  public var border : Null<String>;
  public var timeshifted : Bool = false;
  public var hand : Null<Int>;
  public var life : Null<Int>;
  public var reserved : Bool = false;
  public var releaseDate : String;
  public var starter : Bool = false;

  // mtgjson extended
  public var rulings : Array<{ date: String, text : String }> = [];
  public var foreignNames : Array<{ language: String, name : String, multiverseid: Int }> = [];
  public var printings : Array<String> = [];
  public var originalText : Null<String>;
  public var originalType : Null<String>;
  public var legalities : Array<{ format : String, legality: String }> = [];
  public var source : Null<String>;

  // other fields
  public var latest : Bool = false;

  public static function fromObject(data : {}) : Card {
    return new Card(cast data);
  }
}
