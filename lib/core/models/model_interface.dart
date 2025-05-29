abstract interface class ModelInterface {
  ModelInterface.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
