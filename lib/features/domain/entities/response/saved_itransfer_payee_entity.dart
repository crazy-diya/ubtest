class SavedItransferPayeeEntity {
  String? receiverName;
  String? nickName;
  String? mobileNumber;
  String? email;
  int? id;
  bool? isFavorite;
  bool isSelected;

  SavedItransferPayeeEntity(
      {this.receiverName,
      this.nickName,
      this.mobileNumber,
      this.email,
      this.id,
      this.isFavorite = false,
      this.isSelected = false});
}
