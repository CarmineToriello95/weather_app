class HttpStatusCodeException implements Exception {
  final int statusCode;
  final String message;

  HttpStatusCodeException({required this.statusCode, required this.message});
}
