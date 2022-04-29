class ShopChangePasswordModel {
  bool? status;
  String? message;
  ChangePasswordData? data;

  ShopChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? ChangePasswordData.fromJson(json['data']) : null;
  }
}

class ChangePasswordData {
  String? email;

  ChangePasswordData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
}
