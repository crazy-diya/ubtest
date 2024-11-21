class APIHandler {
  APIHandler({
    this.data,
  });

  String? data;

  factory APIHandler.fromJson(Map<String, dynamic> json) => APIHandler(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
