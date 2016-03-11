package mtg.client.state;

import mtg.core.model.*;
import thx.Error;
import thx.Nil;

typedef HomePageData = Loader<Nil, { collections: Array<Collection>, decks: Array<Deck> }, Error>;
typedef CollectionsPageData = Loader<Nil, { collections: Array<Collection> }, Error>
typedef CollectionPageData = Loader<String, { collection: Collection }, Error>
typedef CardsPageData = Loader<Nil, { cards: Array<Card> }, Error>
typedef CardPageData = Loader<String, { card: Card }, Error>
typedef DecksPageData = Loader<Nil, { decks: Array<Deck> }, Error>
typedef DeckPageData = Loader<String, { deck: Deck }, Error>
typedef ErrorPageData = { message : String };
