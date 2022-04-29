class ShopCategoriesModel {
  bool? status;
  CategoriesModel? data;

  ShopCategoriesModel({this.status, this.data});

  ShopCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoriesModel.fromJson(json['data']) : null;
  }
}

class CategoriesModel {
  int? currentPage;
  List<CategoriesData>? data;

  CategoriesModel({this.currentPage, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data!.add(CategoriesData.fromJson(v));
      });
    }
  }
}

class CategoriesData {
  int? id;
  String? name;
  String? image;

  CategoriesData({this.id, this.name, this.image});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
