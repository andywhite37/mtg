package mtg.client.state;

import mtg.core.model.CardQuery;

enum AppAction {
  ShowPage(page : Page);
  UpdateCardQuery(cardQuery : CardQuery);
  SubmitCardQuery(cardQuery : CardQuery);
}
