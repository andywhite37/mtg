create table card_color(
  id serial primary key,
  color varchar(20) not null
);

create table card_type(
  id serial primary key,
  type varchar(40) not null
);

create table card_super_type(
  id serial primary key,
  type varchar(40) not null
);

create table card_sub_type(
  id serial primary key,
  type varchar(40) not null
);

create table card_rarity(
  id serial primary key,
  rarity varchar(40) not null
);

create table card_border(
  id serial primary key,
  border varchar(40) not null
);

create table card_watermark(
  id serial primary key,
  watermark varchar(40) not null
);

create table language(
  id serial primary key,
  language varchar(40) not null
);
