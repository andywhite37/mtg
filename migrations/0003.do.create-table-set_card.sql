create table set_card (
  card_id varchar(50) references card (id),
  set_code varchar(20) references "set" (code),
  primary key (card_id, set_code)
);
