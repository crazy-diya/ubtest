class CommonCheckBoxResponse {
  CommonCheckBoxResponse({
    this.id,
    this.description,
    this.key,
  });

  final String? id;
  final String? description;
  final String? key;

  factory CommonCheckBoxResponse.fromJson(Map<String, dynamic> json) =>
      CommonCheckBoxResponse(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };

  @override
  String toString() {
    return 'CommonCheckBoxResponse{id: $id, description: $description, key: $key}';
  }
}
