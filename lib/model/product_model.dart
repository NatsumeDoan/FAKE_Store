class ProductModel {
  num? id;
  String? title;
  num price=0;
  String? deseription;
  String? category;
  String? image;
  int SoLuong=1;
  ProductModel(
      {this.id,
      this.title,
      this.image,
      this.deseription,
      this.category,
      this.price=0,
      this.SoLuong=1});

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      deseription: json['deseription'],
      category: json['category'],
      price: json['price']
    );
  }
  void add() async{
    this.SoLuong= this.SoLuong + 1;
  }
  void minus(List<ProductModel> pp) async{
    if(this.SoLuong==1)
      pp.remove(this);
    this.SoLuong= this.SoLuong - 1;
  }
}
