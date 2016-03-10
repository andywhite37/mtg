package mtg.client.state;

import mtg.core.model.*;
import thx.Error;
import thx.Nil;

typedef HomeData = Loader<Nil, { collections: Array<Collection>, decks: Array<Deck> }, Error>;
typedef CollectionsData = Loader<Nil, Array<Collection>, Error>
typedef CollectionData = Loader<String, Collection, Error>
typedef CardsData = Loader<Nil, Array<Card>, Error>
typedef CardData = Loader<String, Card, Error>
typedef DecksData = Loader<Nil, Array<Deck>, Error>
typedef DeckData = Loader<String, Deck, Error>
typedef NotFoundData = { message : String };
