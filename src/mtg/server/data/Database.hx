package mtg.server.data;

import haxe.ds.Option;
import js.Error as JsError;
import mtg.core.model.*;
import npm.PG;
import npm.pg.*;
import thx.promise.Promise;
import thx.Error as ThxError;
using dataclass.Converter;
using mtg.server.data.Database;
using thx.Arrays;

class Database {
  var connectionString : String;

  public function new(connectionString : String) {
    this.connectionString = connectionString;
  }

  public function getCards() : Promise<Array<Card>> {
    return query('select * from cards', Card.fromDynamic.bind(_, null));
  }

  public function getCardById(id : String) : Promise<Card> {
    return query('select * from card where id = $1', [id], Card.fromDynamic.bind(_, null)).single();
  }

  public function createCard(card : Card) : Promise<Card> {
    return query(
      "insert into card (
        id, layout, name, names, mana_cost,
        cmc, colors, color_identity, type, supertypes,
        types, subtypes, rarity, rules_text, flavor_text,
        artist, number, power, toughness, loyalty,
        multiverse_id, variations, image_name, watermark, border,
        timeshifted, hand_modifier, life_modifier, reserved, release_date,
        starter, rulings, foreign_names, printings, original_rules_text,
        original_type, legalities, source, is_latest_printing
      ) values ($1, $2, $3, $4, $5,
        $6, $7, $8, $9, $10,
        $11, $12, $13, $14, $15,
        $16, $17, $18, $19, $20,
        $21, $22, $23, $24, $25,
        $26, $27, $28, $29, $30,
        $31, $32, $33, $34, $35,
        $36, $37, $38, $39)", [
        card.id, card.layout, card.name, card.names,
        card.manaCost, card.cmc, card.colors, card.colorIdentity, card.type, card.supertypes,
        card.types, card.subtypes, card.rarity, card.text, card.flavor,
        card.artist, card.number, card.power, card.toughness, card.loyalty,
        card.multiverseid, card.variations, card.imageName, card.watermark, card.border,
        card.timeshifted, card.hand, card.life, card.reserved, card.releaseDate,
        card.starter, card.rulings, card.foreignNames, card.printings, card.originalText,
        card.originalType, card.legalities, card.source, card.latest,
       ], castConverter)
      .mapSuccessPromise(function(_) {
        return getCardById(card.id);
      });
  }

  public function updateCard(card : Card) : Promise<Card> {
    return query(
      'update card set
        id = $1, layout = $2, name = $3, names = $4, mana_cost = $5,
        cmc = $6, colors = $7, color_identity = $8, type = $9, supertypes = $10,
        types = $11, subtypes = $12, rarity = $13, rules_text = $14, flavor_text = $15,
        artist = $16, number = $17, power = $18, toughness = $19, loyalty = $20,
        multiverse_id = $21, variations = $22, image_name = $23, watermark = $24, border = $25,
        timeshifted = $26, hand_modifier = $27, life_modifier = $28, reserved = $29, release_date = $30,
        starter = $31, rulings = $32, foreign_names = $33, printings = $34, original_rules_text = $35,
        original_type = $36, legalities = $37, source = $38, is_latest_printing = $39
      where id = $1;', [
        card.id, card.layout, card.name, card.names, card.manaCost,
        card.cmc, card.colors, card.colorIdentity, card.type, card.supertypes,
        card.types, card.subtypes, card.rarity, card.text, card.flavor,
        card.artist, card.number, card.power, card.toughness, card.loyalty,
        card.multiverseid, card.variations, card.imageName, card.watermark, card.border,
        card.timeshifted, card.hand, card.life, card.reserved, card.releaseDate,
        card.starter, card.rulings, card.foreignNames, card.printings, card.originalText,
        card.originalType, card.legalities, card.source, card.latest,
      ], castConverter)
      .mapSuccessPromise(function(_) {
        return getCardById(card.id);
      });
  }

  function query<T>(sql : String, ?params: Array<Dynamic>, converter : {} -> T) : Promise<Array<T>> {
    return Promise.create(function(resolve, reject) {
      PG.connect(connectionString, function(err : Null<JsError>, client : Client, done : Done) {
        if (err != null) {
          done();
          reject(ThxError.fromDynamic(err));
          return;
        }
        trace(sql);
        if (params != null) {
          trace(params);
        }
        client.query(sql, params, function(err : Null<JsError>, queryResult : QueryResult) : Void {
          if (err != null) {
            done();
            reject(ThxError.fromDynamic(err));
            return;
          }
          var results = queryResult.rows.map(function(row) {
            var data : {} = row;
            return converter(data);
          });
          done();
          resolve(results);
        });
      });
    });
  }

  function castConverter<T>(row : Row) : T {
    return cast row;
  }

  static function single<T>(promise : Promise<Array<T>>) : Promise<T> {
    return promise.mapSuccessPromise(function(items) {
      return if (items == null || items.length == 0) {
        Promise.error(new thx.Error('Not found'));
      } else {
        Promise.value(items[0]);
      }
    });
  }
}

typedef QueryResult = { rows: Array<Row> };
