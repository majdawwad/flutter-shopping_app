class ShopNotificationModel {
  bool? status;
  String? message;
  NotData? data;

  ShopNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NotData.fromJson(json['data']) : null;
  }
}

class NotData {
  int? currentPage;
  List<Data> data = [];

  NotData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? title;
  String? message;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }
}
