package mtg.core.model;

typedef Card = {
  name : String,
  id : String,
  url : String,
  store_url : String,
  types : Array<String>,
  colors : Array<String>,
  cmc : Int,
  cost : String,
  text : String,
  formats : Dynamic<String>,
  editions : Array<Edition>,
}
