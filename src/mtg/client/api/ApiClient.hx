package mtg.client.api;

import js.jquery.JQuery;
import js.jquery.JqXHR;
import mtg.core.model.*;
import thx.promise.Promise;
import thx.Error;
import mtg.core.util.Arrays;

class ApiClient {
  public function new() {
  }

  public function getCards(options : { cardQuery: CardQuery }) : Promise<Array<Card>> {
    trace(options.cardQuery.toQueryString());
    return http({
      type: 'GET',
      url: '/api/cards?${options.cardQuery.toQueryString()}',
    }, arrayConverter(Card.fromObject));
  }

  public function getCard(cardId : String) : Promise<Card> {
    return http({
      type: 'GET',
      url: '/api/cards/$cardId'
    }, Card.fromObject);
  }

  function http<T>(options : JQueryAjaxOptions, ?converter : Dynamic -> T) : Promise<T> {
    if (converter == null) converter = function(data : Dynamic) : T { return cast data; };
    return Promise.create(function(resolve, reject) {
      options.success = function(data, textStatus, jqXHR) {
        resolve(converter(data));
      };
      options.error = function(jqXHR, textStatus, errorThrown) {
        reject(new Error('API error: ${jqXHR.status}'));
      };
      JQuery.ajax(options);
    });
  }

  public function arrayConverter<T>(converter : Dynamic -> T) {
    return function(input : Dynamic) : Array<T> {
      return Arrays.map(input, converter);
    };
  }
}
