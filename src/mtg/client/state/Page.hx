package mtg.client.state;

import mtg.client.state.Data;

enum Page {
  // Main pages
  HomePage(data : HomePageData);
  CollectionsPage(data : CollectionsPageData);
  CollectionPage(data : CollectionPageData);
  CardsPage(data : CardsPageData);
  CardPage(data : CardPageData);
  DecksPage(data : DecksPageData);
  DeckPage(data : DeckPageData);

  // Error page(s)
  ErrorPage(data : ErrorPageData);
}
