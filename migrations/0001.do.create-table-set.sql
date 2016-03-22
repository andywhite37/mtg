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
  booster jsonb not null,
  search_vector tsvector
);

create index set_search_vector_gin on "set" using gin(search_vector);

create function update_set_search_vector() returns trigger as $$
begin
  new.search_vector :=
    setweight(to_tsvector('pg_catalog.english', coalesce(new.name, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.code, '')), 'A') ||
    setweight(to_tsvector('pg_catalog.english', coalesce(new.block, '')), 'A');
  return new;
end
$$ language plpgsql;

create trigger update_set_search_vector_trigger before insert or update
on "set" for each row execute procedure update_set_search_vector();
