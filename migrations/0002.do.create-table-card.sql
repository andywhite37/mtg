create table card (
  id varchar(50) primary key,
  layout varchar(20) not null,
  name varchar(250) not null,
  names varchar(50)[] not null,
  mana_cost varchar(50) null,
  cmc decimal null,
  colors varchar(50)[] not null,
  color_identity varchar(50)[] not null,
  type varchar(250) not null,
  supertypes varchar(50)[] not null,
  types varchar(50)[] not null,
  subtypes varchar(50)[] not null,
  rarity varchar(50) not null,
  rules_text text null,
  flavor_text text null,
  artist varchar(250) null,
  number varchar(50) null,
  power varchar(20) null,
  toughness varchar(20) null,
  loyalty int null,
  multiverse_id int null,
  variations int[] not null,
  image_name varchar(250) not null,
  watermark varchar(250) null,
  border varchar(20) not null,
  timeshifted boolean not null,
  hand_modifier int null,
  life_modifier int null,
  reserved boolean not null,
  release_date varchar(20) not null,
  starter boolean not null,
  rulings jsonb not null,
  foreign_names jsonb not null,
  printings varchar(10)[] not null,
  original_rules_text text null,
  original_type varchar(250) null,
  legalities jsonb not null,
  source text null,
  latest_printing boolean not null,
  search_vector tsvector
);

create index card_search_vector_gin on "card" using gin(search_vector);

create function update_card_search_vector() returns trigger as $$
begin
  new.search_vector :=
    setweight(to_tsvector('pg_catalog.english', coalesce(new.name, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.rules_text, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.multiverse_id::text, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.artist, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.number, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.watermark, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.flavor_text, '')), 'B') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.rarity, '')), 'B') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.original_rules_text, '')), 'B') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.original_type, '')), 'B');
  return new;
end
$$ language plpgsql;

create trigger update_card_search_vector_trigger before insert or update
on "card" for each row execute procedure update_card_search_vector();
