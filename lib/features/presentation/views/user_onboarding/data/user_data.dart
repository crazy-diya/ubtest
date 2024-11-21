// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  final String username;
  final String currentPass;
  final String confirmPass;
  final String? appBarTitle;

  UserData({
    required this.username,
    required this.currentPass,
    required this.confirmPass,
    this.appBarTitle,
  });
}
