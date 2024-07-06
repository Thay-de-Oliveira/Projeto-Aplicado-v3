import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:projetoaplicado/backend/services/usuarioService.dart';

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner;
  final UserService _authService;
  final storage = FlutterSecureStorage();

  CustomHttpClient(this._inner, this._authService);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null) {
      request.headers['Authorization'] = accessToken;
    }

    final response = await _inner.send(request);

    if (response.statusCode == 401) {
      try {
        await _authService.refreshAccessToken();
        final newAccessToken = await storage.read(key: 'accessToken');
        if (newAccessToken != null) {
          request.headers['Authorization'] = newAccessToken;
          return _inner.send(request);
        }
      } catch (e) {
        await _authService.logoutUser();
      }
    }

    return response;
  }
}