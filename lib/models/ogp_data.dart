class OgpData {
  final String url;
  final String? title;
  final String? description;
  final String? imageUrl;

  OgpData({
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
  });

  @override
  String toString() {
    return 'OgpData(url: $url, title: $title, description: $description, imageUrl: $imageUrl)';
  }
}
