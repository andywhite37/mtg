package mtg.core.model;

using thx.Arrays;
using mtg.core.util.Arrays;

class Card {
  public var name : String;
  public var id : String;
  public var url : String;
  public var storeUrl : String;
  public var types : Array<String>;
  public var colors : Array<String>;
  public var cmc : Int;
  public var cost : String;
  public var text : String;
  public var formats : Dynamic<String>;
  public var editions : Array<Edition>;

  public static function fromDynamic(data : Dynamic) : Card {
    return new Card(data);
  }

  public function new(data : Dynamic) {
    setFromDynamic(data);
  }

  public function setFromDynamic(data : Dynamic) : Void {
    this.name = data.name;
    this.id = data.id;
    this.url = data.url;
    this.storeUrl = data.store_url;
    this.types = data.types;
    this.colors = data.colors;
    this.cmc = data.cmc;
    this.cost = data.cost;
    this.text = data.text;
    this.formats = data.formats;
    this.editions = Arrays.map(data.editions, Edition.fromDynamic);
  }

  public function getLatestEdition() : Edition {
    return editions.order(function(a, b) {
      return thx.Ints.compare(b.multiverseId, a.multiverseId);
    }).first();
  }

  public function getLatestImage() : { src: String, alt: String } {
    var edition = getLatestEdition();
    if (edition == null) {
      return {
        src: "/images/missing-card-image.png",
        alt: name
      };
    }
    return {
      src: edition.imageUrl,
      alt: '$name (${edition.set})'
    };
  }
}
