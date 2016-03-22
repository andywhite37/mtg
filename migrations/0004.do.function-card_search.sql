asdf
create or replace function "card_search"(
  name_search text default '',
  rules_text_search text default ''
) returns table (
  id varchar(50),
  layout varchar(20),
  name varchar(250),
  names varchar(50)[],
  mana_cost varchar(50),
  cmc decimal,
  colors varchar(50)[],
  color_identity varchar(50)[],
  type varchar(250),
  supertypes varchar(50)[],
  types varchar(50)[],
  subtypes varchar(50)[],
  rarity varchar(50),
  rules_text text,
  flavor_text text,
  artist varchar(250),
  number varchar(50),
  power varchar(20),
  toughness varchar(20),
  loyalty int,
  multiverse_id int,
  variations int[],
  image_name varchar(250),
  watermark varchar(250),
  border varchar(20),
  timeshifted boolean,
  hand_modifier int,
  life_modifier int,
  reserved boolean,
  release_date varchar(20),
  starter boolean,
  rulings jsonb,
  foreign_names jsonb,
  printings varchar(10)[],
  original_rules_text text,
  original_type varchar(250),
  legalities jsonb,
  source text,
  latest_printing boolean
) as
$func$
begin
return query

with search_results as (
)

select * from card
where id in (select id from search_results)
order by search_results.rank;

end
$func$ language plpgsql;

select * from card_search('', '');
