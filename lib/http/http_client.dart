import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<dynamic> get(String url);
  Future<dynamic> post(String url, {dynamic data});
  Future<dynamic> put(String url, {dynamic data});
  Future<dynamic> delete(String url);
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get(String url) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future post(String url, {dynamic data}) async {
    return await client.post(Uri.parse(url), body: data);
  }

  @override
  Future put(String url, {dynamic data}) async {
    return await client.put(Uri.parse(url), body: data);
  }

  @override
  Future delete(String url) async {
    return await client.delete(Uri.parse(url));
  }
}