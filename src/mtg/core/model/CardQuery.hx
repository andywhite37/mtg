package mtg.core.model;

import dataclass.DataClass;

enum TextSearchType {
  FullTextSearch;
  ContainsExactMatch;
  IsExactMatch;
}

enum ColorSearchType {
  ContainsAny;
  ContainsAll;
  ExactMatch;
}

@immutable
class CardQuery implements DataClass {
  public var name : Null<String>;
  public var nameSearchType : TextSearchType;
}
