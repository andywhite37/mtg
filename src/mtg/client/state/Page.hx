package mtg.client.state;

import mtg.client.state.Data;
import mtg.core.model.*;
import thx.Error;
import thx.Nil;

enum Page {
  Home(data : HomeData);
  Collections(data : CollectionsData);
  Collection(data : CollectionData);
  Cards(data : CardsData);
  Card(data : CardData);
  Decks(data : DecksData);
  Deck(data : DeckData);

  NotFound(data : NotFoundData);
}
