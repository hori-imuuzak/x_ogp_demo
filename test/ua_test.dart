import 'package:http/http.dart' as http;

void main() async {
  final url =
      'https://x.com/FlutterDev/status/1760000000000000000'; // Example X URL
  // Use a real recent tweet if possible, or just the profile
  final profileUrl = 'https://x.com/FlutterDev';

  final userAgents = [
    'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
    'Mozilla/5.0 (compatible; Twitterbot/1.0)',
    'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'TelegramBot (like TwitterBot)',
    'Slackbot-LinkExpanding 1.0 (+https://api.slack.com/robots)',
  ];

  print('Testing URL: $profileUrl');
  for (final ua in userAgents) {
    try {
      final response = await http.get(
        Uri.parse(profileUrl),
        headers: {'User-Agent': ua},
      );
      print('UA: $ua -> Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Success with UA: $ua');
        // print(response.body.substring(0, 500)); // Peek content
      }
    } catch (e) {
      print('UA: $ua -> Error: $e');
    }
  }
}
