package mtg.server.data;

import haxe.Json;
import haxe.ds.Option;
import js.Error as JsError;
import mtg.core.model.Card;
import mtg.core.model.CardQuery;
import mtg.core.model.Deck;
import mtg.core.model.Set;
import npm.PG;
import npm.pg.*;
import thx.promise.Promise;
import thx.Error as ThxError;
import thx.Nil;
using StringTools;
using dataclass.Converter;
using mtg.server.data.Database;
using thx.Arrays;
using thx.Strings;

class Database {
  var connectionString : String;

  public function new(connectionString : String) {
    this.connectionString = connectionString;
  }

  public function getCards(cardQuery : CardQuery) : Promise<Array<Card>> {
    trace(cardQuery);
    var textQuery = switch cardQuery.textQuery {
      case None : { type: 0, text: '' };
      case ExactMatch(text) : { type: 1, text: text };
      case StartsWith(text) : { type: 1, text: '${text}%' };
      case EndsWith(text) : { type: 1, text: '%${text}' };
      case ContainsAll(text) : { type: 2, text: toTSQueryAll(text) };
      case ContainsAny(text) : { type: 2, text: toTSQueryAny(text) };
    };
    var latestPrintingOnly : Bool = !!cardQuery.latestPrintingOnly;
    var limit : Int = cardQuery.pageSize;
    var offset : Int = (cardQuery.pageNumber - 1) * cardQuery.pageSize;

    return query(
      "select *
      from card

      -- text
      where (
        ($1 = 0) or
        (($1 = 1) and (name ilike $2 or rules_text ilike $2 or flavor_text ilike $2)) or
        (($1 = 2) and (search_vector @@ to_tsquery($2)))
      )

      -- name

      -- rules

      -- flavor

      -- latest printing
      and (($3) or (latest_printing = true))

      -- order

      -- paging
      offset $4
      limit $5
      ;",
      [
        textQuery.type,
        textQuery.text,
        latestPrintingOnly,
        offset,
        limit
      ],
      Database.rowToCard);
  }

  public function getCardById(id : String) : Promise<Card> {
    return query('select * from card where id = $1', [id], Database.rowToCard).singleRow();
  }

  public function hasCardById(id : String) : Promise<Bool> {
    return query('select count(1) as count from card where id = $1', [id], Database.rowToCountRow).exists();
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
        original_type, legalities, source, latest_printing
      ) values ($1, $2, $3, $4, $5,
        $6, $7, $8, $9, $10,
        $11, $12, $13, $14, $15,
        $16, $17, $18, $19, $20,
        $21, $22, $23, $24, $25,
        $26, $27, $28, $29, $30,
        $31, $32, $33, $34, $35,
        $36, $37, $38, $39
      )", [
        card.id, card.layout, card.name, card.names, card.manaCost,
        card.cmc, card.colors, card.colorIdentity, card.type, card.supertypes,
        card.types, card.subtypes, card.rarity, card.text, card.flavor,
        card.artist, card.number, card.power, card.toughness, card.loyalty,
        card.multiverseid, card.variations, card.imageName, card.watermark, card.border,
        card.timeshifted, card.hand, card.life, card.reserved, card.releaseDate,
        card.starter, jstr(card.rulings), jstr(card.foreignNames), card.printings, card.originalText,
        card.originalType, jstr(card.legalities), card.source, card.latest,
      ])
      .mapSuccessPromise(function(_) {
        return getCardById(card.id);
      });
  }

  public function updateCard(card : Card) : Promise<Card> {
    return query(
      "update card set
        layout = $2, name = $3, names = $4, mana_cost = $5,
        cmc = $6, colors = $7, color_identity = $8, type = $9, supertypes = $10,
        types = $11, subtypes = $12, rarity = $13, rules_text = $14, flavor_text = $15,
        artist = $16, number = $17, power = $18, toughness = $19, loyalty = $20,
        multiverse_id = $21, variations = $22, image_name = $23, watermark = $24, border = $25,
        timeshifted = $26, hand_modifier = $27, life_modifier = $28, reserved = $29, release_date = $30,
        starter = $31, rulings = $32, foreign_names = $33, printings = $34, original_rules_text = $35,
        original_type = $36, legalities = $37, source = $38, latest_printing = $39
      where id = $1;
      ", [
        card.id, card.layout, card.name, card.names, card.manaCost,
        card.cmc, card.colors, card.colorIdentity, card.type, card.supertypes,
        card.types, card.subtypes, card.rarity, card.text, card.flavor,
        card.artist, card.number, card.power, card.toughness, card.loyalty,
        card.multiverseid, card.variations, card.imageName, card.watermark, card.border,
        card.timeshifted, card.hand, card.life, card.reserved, card.releaseDate,
        card.starter, jstr(card.rulings), jstr(card.foreignNames), card.printings, card.originalText,
        card.originalType, jstr(card.legalities), card.source, card.latest,
      ])
      .mapSuccessPromise(function(_) {
        return getCardById(card.id);
      });
  }

  public function deleteCard(card : Card) : Promise<Nil> {
    return deleteCardById(card.id);
  }

  public function deleteCardById(id : String) : Promise<Nil> {
    return query('delete from card where id = $1', [id]).nil();
  }

  public function getSets() : Promise<Array<Set>> {
    return query('select * from set', Database.rowToSet);
  }

  public function getSetByCode(code : String) : Promise<Set> {
    return query('select * from set where code = $1', [code], Database.rowToSet).singleRow();
  }

  public function hasSetByCode(code : String) : Promise<Bool> {
    return query('select count(1) from set where code = $1', [code], Database.rowToCountRow).exists();
  }

  public function createSet(set : Set) : Promise<Set> {
    return query(
      "insert into set (
        code, name, gatherer_code, old_code, magic_cards_info_code,
        release_date, border, type, block, online_only,
        booster
      ) values (
        $1, $2, $3, $4, $5,
        $6, $7, $8, $9, $10,
        $11
      )", [
        set.code, set.name, set.gathererCode, set.oldCode, set.magicCardsInfoCode,
        set.releaseDate, set.border, set.type, set.block, set.onlineOnly,
        jstr(set.booster)
      ])
      .mapSuccessPromise(function(_) {
        return getSetByCode(set.code);
      });
  }

  public function updateSet(set : Set) : Promise<Set> {
    return query(
      "update \"set\" set
        name = $2, gatherer_code = $3, old_code = $4, magic_cards_info_code = $5,
        release_date = $6, border = $7, type = $8, block = $9, online_only = $10,
        booster = $11
      where code = $1;", [
        set.code, set.name, set.gathererCode, set.oldCode, set.magicCardsInfoCode,
        set.releaseDate, set.border, set.type, set.block, set.onlineOnly,
        jstr(set.booster)
      ])
      .mapSuccessPromise(function(_) {
        return getSetByCode(set.code);
      });
  }

  public function deleteSet(set : Set) : Promise<Nil> {
    return deleteSetByCode(set.code);
  }

  public function deleteSetByCode(code : String) : Promise<Nil> {
    return query('delete from set where code = $1', [code]).nil();
  }

  public function createSetCard(setCode : String, cardId : String) : Promise<Nil> {
    return query('insert into set_card (set_code, card_id) values($1, $2)', [setCode, cardId]).nil();
  }

  public function hasSetCard(setCode : String, cardId : String) : Promise<Bool> {
    return query('select count(1) as count from set_card where set_code = $1 and card_id = $2', [setCode, cardId], Database.rowToCountRow).exists();
  }

  public function deleteSetCard(setCode : String, cardId : String) : Promise<Nil> {
    return query('delete from set_card where set_code = $1 and card_id = $2', [setCode, cardId]).nil();
  }

  public function rankCards() : Promise<Nil> {
    return query('update card set latest_printing = false;')
      .nil()
      .mapSuccessPromise(function(_) {
        return query(
          'update card set latest_printing = true
          where id in (
            select c1.id
            from card c1
            inner join (
              select name, max(release_date) as release_date
              from card group by name
            ) as c2 on c1.name = c2.name and c1.release_date = c2.release_date
            order by c1.name
          );');
      })
      .nil();
  }

  function query<T>(sql : String, ?params: Array<Dynamic>, ?converter : Row -> T) : Promise<Array<T>> {
    if (converter == null) converter = Database.rowToAny;
    return Promise.create(function(resolve, reject) {
      PG.connect(connectionString, function(err : Null<JsError>, client : Client, done : Done) {
        if (err != null) {
          done();
          reject(ThxError.fromDynamic(err));
          return;
        }
        trace('---- SQL ----');
        trace(sql);
        if (params != null) {
          trace(params);
        }
        trace('-------------');
        client.query(sql, params, function(err : Null<JsError>, queryResult : QueryResult) : Void {
          if (err != null) {
            done();
            reject(ThxError.fromDynamic(err));
            return;
          }
          var results = queryResult.rows.map(function(row : Row) : T {
            return converter(row);
          });
          done();
          resolve(results);
        });
      });
    });
  }

  static function firstRow<T>(promise : Promise<Array<T>>) : Promise<T> {
    return promise.mapSuccessPromise(function(items) {
      return if (items == null || items.length == 0) {
        Promise.error(new thx.Error('Expected at least one row'));
      } else {
        Promise.value(items[0]);
      }
    });
  }

  static function singleRow<T>(promise : Promise<Array<T>>) : Promise<T> {
    return promise.mapSuccessPromise(function(items) {
      return if (items == null || items.length != 1) {
        Promise.error(new thx.Error('Expected exactly one row'));
      } else {
        Promise.value(items[0]);
      }
    });
  }

  static function singleCountRow<T : { count: Int }>(promise : Promise<Array<T>>) : Promise<Int> {
    return promise.singleRow().mapSuccess(function(countRow) {
      return countRow.count;
    });
  }

  static function exists<T : { count : Int }>(promise : Promise<Array<T>>) : Promise<Bool> {
    return promise.singleCountRow().mapSuccess(function(count) {
      return count > 0;
    });
  }

  static function nil<T>(promise : Promise<Array<T>>) : Promise<Nil> {
    return promise.mapSuccessPromise(function(_) {
      return Promise.nil;
    });
  }

  static function rowToAny<T>(row : Row) : T {
    return cast row;
  }

  static function rowToCard(row : Row) : Card {
    return new Card({
      id: row.id, layout: row.layout, name: row.name, names: row.names, manaCost: row.mana_cost,
      cmc: row.cmc, colors: row.colors, colorIdentity: row.color_identity, type: row.type, supertypes: row.supertypes,
      types: row.types, subtypes: row.subtypes, rarity: row.rarity, text: row.rules_text, flavor: row.flavor_text,
      artist: row.artist, number: row.number, power: row.power, toughness: row.toughness, loyalty: row.loyalty,
      multiverseid: row.multiverse_id, variations: row.variations, imageName: row.image_name, watermark: row.watermark, border: row.border,
      timeshifted: row.timeshifted, hand: row.hand_modifier, life: row.life_modifier, reserved: row.reserved, releaseDate: row.release_date,
      starter: row.starter, rulings: row.rulings, foreignNames: row.foreign_names, printings: row.printings, originalText: row.original_rules_text,
      originalType: row.original_type, legalities: row.legalities, source: row.source, latest: row.latest_printing,
    });
  }

  static function rowToSet(row : Row) : Set {
    return new Set({
      code: row.code, name: row.name, gathererCode: row.gatherer_code, oldCode: row.old_code, magicCardsInfoCode: row.magic_cards_info_code,
      releaseDate: row.release_date, border: row.border, type: row.type, block: row.block, onlineOnly: row.online_only,
      booster: row.booster
    });
  }

  static function rowToCountRow(row : Row) : { count : Int } {
    return cast row;
  }

  function jstr(input : Dynamic) : String {
    return Json.stringify(input);
  }

  function toTSQueryAll(input : String) : String {
    input = input.trim();
    return ~/\s+/.replace(input, ' & ');
  }

  function toTSQueryAny(input : String) : String {
    input = input.trim();
    return ~/\s+/.replace(input, ' | ');
  }
}

typedef QueryResult = { rows: Array<Row> };
