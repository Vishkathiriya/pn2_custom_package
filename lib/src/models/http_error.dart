
class HttpError implements Exception {

  final int statusCode;
  final String message;

  HttpError(this.statusCode, this.message);

  @override
  String toString() {
    return "HttpError: code: $statusCode, message: $message";
  }

}
