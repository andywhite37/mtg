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

  public function getCards() : Promise<Array<Card>> {
    return http({
      type: 'GET',
      url: '/api/cards',
    });
  }

  public function getCard(cardId : String) : Promise<Card> {
    return http({
      type: 'GET',
      url: '/api/cards/$cardId'
    });
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

  public function fromArray<T>(converter : Dynamic -> T) {
    return function(input : Dynamic) : Array<T> {
      return Arrays.map(input, converter);
    };
  }
}
