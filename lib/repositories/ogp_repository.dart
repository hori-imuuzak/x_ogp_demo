import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import '../models/ogp_data.dart';

class OgpRepository {
  Future<OgpData> fetchOgp(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Mozilla/5.0 (compatible; Twitterbot/1.0)',
        },
      );

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        String? title = _getMetaContent(document, 'og:title');
        if (title == null || title.isEmpty) {
          title = document.querySelector('title')?.text;
        }

        String? description = _getMetaContent(document, 'og:description');
        if (description == null || description.isEmpty) {
          description = _getMetaContent(document, 'description');
        }

        String? imageUrl = _getMetaContent(document, 'og:image');

        return OgpData(
          url: url,
          title: title,
          description: description,
          imageUrl: imageUrl,
        );
      } else {
        throw Exception('Failed to load OGP data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch OGP: $e');
    }
  }

  String? _getMetaContent(Document document, String property) {
    var meta = document.querySelector('meta[property="$property"]');
    meta ??= document.querySelector('meta[name="$property"]');
    return meta?.attributes['content'];
  }
}
