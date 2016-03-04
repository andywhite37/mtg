package mtg.server.error;

import express.*;
import js.Error;

class ErrorHandler {
  public static function handle(err : Error, req : Request, res : Response, next : Next) : Void {
    if (Std.is(err, HttpError)) handleHttpError(cast err, req, res, next);
    else if (Std.is(err, ValidationError)) handleValidationError(cast err, req, res, next);
    else handleUnknownError(err, req, res, next);
  }

  public static function handleHttpError(err : HttpError, req : Request, res : Response, next : Next) : Void {
    trace('HTTP error: ${err.statusCode} - ${req.originalUrl} - ${err.message}');
    //trace(err);
    var innerError = switch err.innerError {
      case Some(innerError) : innerError;
      case None : null;
    };
    sendError(res, err.statusCode, err.message, innerError);
  }

  public static function handleValidationError(err : ValidationError, req : Request, res : Response, next : Next) : Void {
    trace('Validation error: ${err.message}');
    //trace(err);
    sendError(res, 400, err.message, err);
  }

  public static function handleUnknownError(err : Error, req : Request, res : Response, next : Next) : Void {
    trace('Unexpected error: ${err.message}');
    //trace(err);
    sendError(res, 500, err.message, err);
  }

  static function sendError(res : Response, status : Int, message : String, ?innerError : Error) : Void {
    res.status(status).send({
      status: status,
      message: message,
      error: innerError != null ? innerError.message : 'no inner error',
    });
  }
}
