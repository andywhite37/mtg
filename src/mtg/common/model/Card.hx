package mtg.common.model;

typedef Card = {
  public var name : String;
  public var id : String;
  public var url : String;
  public var store_url : String;
  public var types : Array<String>;
  public var colors : Array<String>;
  public var cmc : Int;
  public var cost : String;
  public var text : String;
  public var formats : Dynamic<String>;
  public var editions : Array<Edition>;
}
