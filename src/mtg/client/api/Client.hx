package mtg.client.api;

import js.jquery.JQuery;
import js.jquery.JqXHR;
import mtg.common.model.*;
import thx.promise.Promise;
import thx.Error;

class Client {
  public function new() {
  }

  public function getCards() : Promise<Array<Card>> {
    return http({
      type: 'GET',
      url: '/api/cards',
    });
  }

  function http<T>(options : JQueryAjaxOptions, ?converter : Dynamic -> T) : Promise<T> {
    if (converter == null) converter = function(data : Dynamic) : T { return cast data; };
    return Promise.create(function(resolve, reject) {
      options.success = function(data, textStatus, jqXHR) {
        resolve(converter(data));
      };
      options.error = function(jqXHR, textStatus, errorThrown) {
        reject(new Error('API error ${jqXHR.status}'));
      };
      JQuery.ajax(options);
    });
  }
}
