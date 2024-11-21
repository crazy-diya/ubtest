// ignore_for_file: public_member_api_docs, sort_constructors_first

class PhoneContact {
  String id;
  String phoneNumber;
  String? displayName;
  bool? isUbUser;
  String? firstLetter;

  PhoneContact({
    required this.id,
    required this.phoneNumber,
    this.displayName,
    this.isUbUser,
    this.firstLetter,
  });

  @override
  String toString() {
    return 'PhoneContact(id: $id, phoneNumber: $phoneNumber, displayName: $displayName, isUbUser: $isUbUser , firstLetter: $firstLetter )';
  }
}
