import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pn2_package/src/models/http_error.dart';
import 'package:pn2_package/src/service/pn2_cache_manager.dart';
import '../utils/encrypt_utils.dart';

enum _HttpMethod {
  get, post, put, patch, delete
}

class Pn2Request {

  static bool _ok(int statusCode) => statusCode >= 200 && statusCode <= 299;

  static Future<http.Response> get(Uri url, {
    Map<String, String>? headers,
    bool useCache = false
  }) async {
    return _makeRequest(
      _HttpMethod.get,
      url,
      headers: headers,
      useCache: useCache
    );
  }

  static Future<http.Response> post(Uri url, {
    Map<String, String>? headers,
    String? body,
    bool useCache = false
  }) async {
    return _makeRequest(
      _HttpMethod.post,
      url,
      headers: headers,
      body: body,
      useCache: useCache
    );
  }

  static Future<http.Response> put(Uri url, {
    Map<String, String>? headers,
    String? body,
    bool useCache = false
  }) async {
    return _makeRequest(
      _HttpMethod.put,
      url,
      headers: headers,
      body: body,
      useCache: useCache
    );
  }

  static Future<http.Response> patch(Uri url, {
    Map<String, String>? headers,
    String? body,
    bool useCache = false
  }) async {
    return _makeRequest(
      _HttpMethod.patch,
      url,
      headers: headers,
      body: body,
      useCache: useCache
    );
  }

  static Future<http.Response> delete(Uri url, {
    Map<String, String>? headers,
    String? body,
    bool useCache = false
  }) async {
    return _makeRequest(
      _HttpMethod.delete,
      url,
      headers: headers,
      body: body,
      useCache: useCache
    );
  }

  static Future<http.Response> _makeRequest(_HttpMethod method, Uri url, {
    Map<String, String>? headers,
    String? body,
    bool useCache = false
  }) async {

    Map<String, String> newHeaders = {};

    if (headers != null)
      headers = {
        ...newHeaders
      };

    var encryptData = EncryptUtils.encrypt(body);
    newHeaders['X-PN2-KEYS'] = encryptData.headerKey;

    try {

      final response = await _buildRequest(
        method,
        url,
        headers: newHeaders,
        body: encryptData.data
      );

      final String encrypted = json.decode(response.body)['result'];
      final decrypted = EncryptUtils.decrypt(encrypted, encryptData.key, encryptData.iv);

      /// Si on precise que la requête on doit etre mis en cache
      /// Et qu'elle(la requête) s'est bien effectue dans ce cas on la met en cache
      if (_ok(response.statusCode)) {
        if (useCache) {
          Pn2CacheManager.set(url.toString(), decrypted);
        }
      } else {
        /// Si le status code de la requête n'est pas dans l'intervalle [200-299]
        throw HttpError(response.statusCode, decrypted);
      }

      return copyResponseWith(response, decrypted);
    } catch(e) {
      if (useCache && e is SocketException) {
        String? cachedBody = await Pn2CacheManager.get(url.toString());

        if (cachedBody != null) {
          return http.Response(cachedBody, 200);
        }

        rethrow;
      } else {
        rethrow;
      }
    }
  }

  static Future<http.Response> _buildRequest(_HttpMethod method, Uri url, {
    Map<String, String>? headers,
    String? body
  }) {
    switch(method) {
      case _HttpMethod.get:
        return http.get(url, headers: headers);
      case _HttpMethod.post:
        return http.post(url, headers: headers, body: body);
      case _HttpMethod.put:
        return http.put(url, headers: headers, body: body);
      case _HttpMethod.patch:
        return http.patch(url, headers: headers, body: body);
      case _HttpMethod.delete:
        return http.delete(url, headers: headers, body: body);
    }
  }

  static http.Response copyResponseWith(http.Response response, String newBody) {
    return http.Response(
      newBody,
      response.statusCode,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase
    );
  }

}
