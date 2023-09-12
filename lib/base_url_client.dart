import 'package:http/http.dart' as http;

/// BaseUrlClient create a http client that support baseUrl.
class BaseUrlClient extends http.BaseClient {
  final http.Client _client;

  final Uri _baseUrl;

  // Create a BaseUrlClient. [client] will be closed internally.
  BaseUrlClient(this._client, this._baseUrl);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(BaseUrlRequest(request, _baseUrl));
  }

  @override
  void close() {
    _client.close();
    super.close();
  }
}

class BaseUrlRequest implements http.BaseRequest {
  final http.BaseRequest _request;

  BaseUrlRequest(this._request, Uri baseUrl)
      : url = baseUrl.resolveUri(_request.url);

  @override
  int? get contentLength => _request.contentLength;
  @override
  set contentLength(int? value) => _request.contentLength = value;

  @override
  bool get followRedirects => _request.followRedirects;
  @override
  set followRedirects(bool value) => _request.followRedirects = value;

  @override
  int get maxRedirects => _request.maxRedirects;
  @override
  set maxRedirects(int value) => _request.maxRedirects = value;

  @override
  bool get persistentConnection => _request.persistentConnection;
  @override
  set persistentConnection(bool value) => _request.persistentConnection = value;

  @override
  http.ByteStream finalize() => _request.finalize();

  @override
  bool get finalized => _request.finalized;

  @override
  Map<String, String> get headers => _request.headers;

  @override
  String get method => _request.method;

  @override
  Future<http.StreamedResponse> send() => _request.send();

  @override
  final Uri url;

  @override
  String toString() => '$method $url';
}
