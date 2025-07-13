import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../domain/entities/register/register_entity.dart';
import '../../domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final http.Client client;

  RegisterRepositoryImpl(this.client);

  @override
  Future<bool> register(RegisterEntity entity) async {
    final url = Uri.parse('http://192.168.1.5:8080/api/auth/register');

    final body = {
      'username': entity.username,
      'email': entity.email,
      'password': entity.password,
      'confirmPassword': entity.confirmPassword,
      'fullName': entity.fullName,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Connection': 'keep-alive',
      'Cache-Control': 'no-cache',
    };

    try {
      print('🚀 Đang gửi request đến: $url');
      print('📦 Body: ${jsonEncode(body)}');
      print('📋 Headers: $headers');

      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print('📥 Status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 403) {
        throw Exception(
          'Server từ chối truy cập (403). Kiểm tra server có đang chạy không?',
        );
      } else if (response.statusCode == 404) {
        throw Exception(
          'API endpoint không tồn tại (404). Kiểm tra URL endpoint.',
        );
      } else if (response.statusCode == 500) {
        throw Exception('Lỗi server nội bộ (500). Vui lòng thử lại sau.');
      } else {
        // Chỉ decode nếu body không rỗng
        if (response.body.isNotEmpty) {
          try {
            final responseBody = jsonDecode(response.body);
            throw Exception(
              responseBody['message'] ?? 'Lỗi server: ${response.statusCode}',
            );
          } catch (e) {
            throw Exception(
              'Lỗi server: ${response.statusCode} - ${response.body}',
            );
          }
        } else {
          throw Exception(
            'Server trả về lỗi ${response.statusCode} với body rỗng. Kiểm tra server có đang chạy không?',
          );
        }
      }
    } on http.ClientException catch (e) {
      print('❌ Lỗi kết nối: $e');
      throw Exception(
        'Không thể kết nối đến server. Kiểm tra:\n1. Server có đang chạy không?\n2. IP address có đúng không?\n3. Port có đúng không?',
      );
    } on SocketException catch (e) {
      print('❌ Lỗi socket: $e');
      throw Exception(
        'Không thể kết nối đến server. Kiểm tra server có đang chạy không?',
      );
    } catch (e) {
      print('❌ Lỗi khi gọi API đăng ký: $e');
      throw Exception('Lỗi không xác định: $e');
    }
  }
}
