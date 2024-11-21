class NewsFeedViewEntity{
  final String title;
  final String subTitle;
  final String age;
  final String image;
  final String linkNews;
  final DateTime? details;

  NewsFeedViewEntity({required this.title,  this.details, required this.subTitle, required this.age, required this.image, required this.linkNews});
}
