package mtg.server.error;

import thx.Error;
import haxe.ds.Option;

class HttpError extends Error {
  public var statusCode(default, null) : Int;
  public var innerError(default, null) : Option<Error>;

  public function new(message, statusCode, innerError) {
    super(message);
    this.statusCode = statusCode;
    this.innerError = innerError;
  }

  public static function notFound(message, innerError) : HttpError {
    return new HttpError(message, 404, innerError);
  }
}
