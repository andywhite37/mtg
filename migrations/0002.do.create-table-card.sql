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

  latest_printing boolean not null
);
