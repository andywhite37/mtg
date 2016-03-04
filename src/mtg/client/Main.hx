package mtg.client;

import js.jquery.JQuery;
import mtg.client.api.Client;

class Main {
  public static var apiClient : Client;

  public static function main() {
    apiClient = new Client();
    new JQuery(function() {
      var root = new JQuery('#root');
      apiClient.getCards()
        .success(function(cards) {
          var ul = root.append('<ul>');
          for (card in cards) {
            ul.append(new JQuery('<li>').text(card.name));
          }
        });
    });
  }
}
