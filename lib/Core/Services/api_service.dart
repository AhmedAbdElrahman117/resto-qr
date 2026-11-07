import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> post({
    required String url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    final link = Uri.parse(url);

    try {
      final response = await http.post(
        link,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'POST request failed with status: ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  Future<dynamic> multipartPost({
    required String url,
    Map<String, String>? headers,
    required Map<String, String> fields,
    required Map<String, String> files,
  }) async {
    final link = Uri.parse(url);

    try {
      var request = http.MultipartRequest('POST', link);
      request.headers.addAll(headers ?? {});

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      for (var entry in files.entries) {
        var fileBytes = await http.MultipartFile.fromPath(
          entry.key,
          entry.value,
        );
        request.files.add(fileBytes);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Multipart POST request failed with status: ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Multipart POST request failed: $e');
    }
  }
}
