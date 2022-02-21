class ChangeCartModel {
  bool? status;
  String? message;
  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
