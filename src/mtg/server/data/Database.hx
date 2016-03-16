package mtg.server.data;

import js.Error as JsError;
import mtg.core.model.*;
import npm.PG;
import npm.pg.*;
import thx.promise.Promise;
import thx.Error as ThxError;
using thx.Arrays;
using dataclass.Converter;

class Database {
  var connectionString : String;

  public function new(connectionString : String) {
    this.connectionString = connectionString;
  }

  public function getCards() : Promise<Array<Card>> {
    return query('select * from cards', Card.fromDynamic.bind(_, null));
  }

  public function getCardById(id : String) : Promise<Card> {
    return Promise.error(new thx.error.NotImplemented());
  }

  function query<T>(sql : String, converter : {} -> T) : Promise<Array<T>> {
    return Promise.create(function(resolve, reject) {
      PG.connect(connectionString, function(err : Null<JsError>, client : Client, done : Done) {
        if (err != null) {
          reject(ThxError.fromDynamic(err));
          return;
        }
        client.query(sql, function(err : Null<JsError>, queryResult : { rows: Array<Row> }) : Void {
          if (err != null) {
            reject(ThxError.fromDynamic(err));
            return;
          }
          var results = queryResult.rows.map(function(row) {
            var data : {} = row;
            return converter(data);
          });
          resolve(results);
        });
      });
    });
  }
}
