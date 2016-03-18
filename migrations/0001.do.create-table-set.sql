create table set (
  code varchar(20) not null primary key,
  name varchar(250) not null,
  gatherer_code varchar(20) null,
  old_code varchar(20) null,
  magic_cards_info_code varchar(20) null,
  release_date varchar(20) not null,
  border varchar(20) not null,
  type varchar(20) not null,
  block varchar(50) null,
  online_only boolean not null,
  booster jsonb not null
);
