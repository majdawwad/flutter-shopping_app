class ShopProfileModel {
  bool? status;
  ProfileData? data;

  ShopProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
