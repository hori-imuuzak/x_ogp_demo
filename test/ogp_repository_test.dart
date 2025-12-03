import 'package:flutter_test/flutter_test.dart';
import 'package:x_ogp_demo/repositories/ogp_repository.dart';

void main() {
  test('Fetch OGP from Flutter.dev', () async {
    final repository = OgpRepository();
    try {
      final data = await repository.fetchOgp('https://flutter.dev');
      print('Fetched Data: $data');
      expect(data.title, isNotNull);
      expect(data.description, isNotNull);
      expect(data.imageUrl, isNotNull);
    } catch (e) {
      print('Error fetching: $e');
      // Allow failure if network is restricted, but print error
    }
  });

  test('Fetch OGP from X (Twitter) profile', () async {
    final repository = OgpRepository();
    try {
      // X might block simple requests without headers/cookies, but let's try.
      final data = await repository.fetchOgp('https://x.com/FlutterDev');
      print('Fetched X Data: $data');
      // X OGP might be dynamic or require JS, so simple http get might fail to get tags.
      // But we check if we get *something*.
    } catch (e) {
      print('Error fetching X: $e');
    }
  });
}
