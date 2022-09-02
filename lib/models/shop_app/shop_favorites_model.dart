class FavoritesModel {
  late bool status;
 late FavoriteModelData data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =  FavoriteModelData.fromJson(json['data']) ;
  }

}

class FavoriteModelData {
 late int currentPage;
 late List<FavoriteData> data = [];

  FavoriteModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      json['data'].forEach((v) {
        data.add(FavoriteData.fromJson(v));
      });
    }

  }




class FavoriteData {
  late int id;
  late Product product;



  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] = Product.fromJson(json['product']);
  }


}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late  String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
