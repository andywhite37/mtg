package mtg.core.util;

class Arrays {
  public static function map<TIn, TOut>(arr : Array<TIn>, mapper : TIn -> TOut) : Array<TOut> {
    var result : Array<TOut> = [];
    for (val in arr) {
      result.push(mapper(val));
    }
    return result;
  }
}
