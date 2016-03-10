package mtg.client.state;

import mtg.client.state.Data;

enum Page {
  // Main pages
  Home(data : HomeData);
  Collections(data : CollectionsData);
  Collection(data : CollectionData);
  Cards(data : CardsData);
  Card(data : CardData);
  Decks(data : DecksData);
  Deck(data : DeckData);

  // Error page(s)
  NotFound(data : NotFoundData);
}
