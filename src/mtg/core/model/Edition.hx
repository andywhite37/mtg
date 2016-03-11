package mtg.core.model;

class Edition {
  public var set(default, null) : String;
  public var rarity(default, null) : String;
  public var artist(default, null) : String;
  public var multiverseId(default, null) : Int;
  public var flavor(default, null) : String;
  public var number(default, null) : String;
  public var layout(default, null) : String;
  public var price(default, null) : { low : Float, average : Float, high : Float };
  public var url(default, null) : String;
  public var imageUrl(default, null) : String;
  public var setUrl(default, null) : String;
  public var storeUrl(default, null) : String;

  public static function fromDynamic(data : Dynamic) : Edition {
    return new Edition(data);
  }

  public function new(data : Dynamic) {
    setFromDynamic(data);
  }

  public function setFromDynamic(data : Dynamic) : Void {
    this.set = data.set;
    this.rarity = data.rarity;
    this.artist = data.artist;
    this.multiverseId = data.multiverse_id;
    this.flavor = data.flavor;
    this.number = data.number;
    this.layout = data.layout;
    this.price = data.price;
    this.url = data.url;
    this.imageUrl = data.image_url;
    this.setUrl = data.set_url;
    this.storeUrl = data.store_url;
  }
}
