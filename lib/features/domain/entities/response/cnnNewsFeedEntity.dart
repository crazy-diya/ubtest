class CnnNewsFeedViewEntity{
  final String cTitle;
  final String cSubTitle;
  final String cImage;
  final String cLinkNews;
  final DateTime? cDetails;

  CnnNewsFeedViewEntity({required this.cTitle,
    this.cDetails, required this.cSubTitle,
    required this.cImage, required this.cLinkNews});
}
