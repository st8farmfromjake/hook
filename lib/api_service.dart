import 'package:http/http.dart' as http;
import 'dart:convert';
import 'firestore.dart';

class ApiService { 
  static const String _apiKey = "sk_CQhvilZt4avQJCg6"; // Consider moving sensitive info like API keys to a secure place
  static int _cachedLinksClicked = 0;
  static const String _domain = 'link.wolltechnologies.com';

  Future<int> getTotalClicks({String? linkID='lnk_4oZz_N7F0JFRThspRuuc3UGvj3'}) async {
    const String baseUrl = "https://api-v2.short.io/statistics/link/";
    // Construct the full URL with query parameters using the Uri class
    final uri = Uri.parse("$baseUrl$linkID").replace(queryParameters: {
      'period': 'today',
      'tz': 'UTC',
    });

    final response = await http.get(uri, headers: {
      'Accept': '*/*',
      'Authorization': _apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cachedLinksClicked = data['totalClicks'];
      return _cachedLinksClicked;
    } else {
      // Handle error or throw an exception
      throw Exception('Failed to load total clicks');
    }
  }

  static int getCachedLinksClicked() {
    return _cachedLinksClicked;
  }

  Future<Map<String, dynamic>> createNewLink({String? originalURL='novusomni.com/hook'}) async {
    const String baseUrl = 'https://api.short.io/links';
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'domain': _domain,
        'originalURL': originalURL,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Assuming 'path' and 'idString' are the keys in the response
      final String path = data['path'];
      final String linkId = data['idString'];
      await updateDocument("unique_document_id", {
        "linkId": linkId,
        "path": path
      });
      // You could directly return these values, or save them as needed
      return {'path': path, 'linkId': linkId};
    } else {
      // Handle the case where the server responds with an error
      throw Exception('Failed to create link');
    }
  }
}