class ChangeFavoritsModel {
  bool? status;
  String? message;
  ChangeFavoritsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
