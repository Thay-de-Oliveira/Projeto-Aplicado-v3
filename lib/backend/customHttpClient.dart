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
    await _ensureTokenIsValid();
    return _sendWithToken(request, await _authService.getAccessToken());
  }

  Future<void> _ensureTokenIsValid() async {
    final expiryDate = await _authService.getExpiryDate();
    if (expiryDate != null && expiryDate.isBefore(DateTime.now())) {
      await _authService.refreshAccessToken();
    } else {
      print('Token is valid.');
    }
  }

  Future<http.StreamedResponse> _sendWithToken(http.BaseRequest request, String? token) async {
    if (token != null) {
      request.headers['Authorization'] = token;
    }

    try {
      return await _inner.send(request);
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }
  }
}