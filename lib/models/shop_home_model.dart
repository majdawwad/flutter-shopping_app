class ShopHomeModel {
  bool? status;
  HomeData? data;
  ShopHomeModel({
    this.status,
    this.data,
  });

  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  late List<BannersData> banners = [];
  late List<ProdactsData> products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners.add(BannersData.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProdactsData.fromJson(element));
      });
    }
  }
}

class BannersData {
  int? id;
  String? image;

  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProdactsData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProdactsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
