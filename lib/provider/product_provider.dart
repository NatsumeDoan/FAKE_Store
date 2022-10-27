import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier{
    List<ProductModel> list=[];
    List<String> list2=[];
    List<ProductModel> listCart=[];
    List<ProductModel> listproduct=[];
    String categlory = "none";
    num id = 0;
    bool showGrid= true;
    void show(bool isGrid){
      showGrid=isGrid;
      notifyListeners();
    }
    void getList() async{
      String apiURL ='https://fakestoreapi.com/products';
      var client = http.Client();
      var rs= await client.get(Uri.parse(apiURL));
      var jsonString= rs.body;
      var jsonObject= jsonDecode(jsonString) as List;
      list =jsonObject.map((e){
        return ProductModel.fromJson(e);
      }).toList();
      notifyListeners();
      this.getCateglory();
    }
    void getCateglory() async {
      this.list.map((e) {
        if (!list2.contains(e.category.toString())) {
          list2.add(e.category.toString());
        }
      }).toList();

    }
    void addtocart(num? id, String? title,num price, String? deseription, String? category, String? image, int SoLuong){
      for(int i=0;i<listCart.length;i++){
        if(listCart[i].id==id){
          listCart[i].add();
          return;
        }
      }
      ProductModel p=new ProductModel(id:id,title: title,price:  price,deseription:  deseription,category:  category,image:  image,SoLuong:  SoLuong);
      listCart.add(p);
    }
    void product(num? id, String? title,num price, String? deseription, String? category, String? image, int SoLuong){
      if(listproduct!=null)
        listproduct.clear();
      ProductModel p=new ProductModel(id:id,title: title,price:  price,deseription:  deseription,category:  category,image:  image,SoLuong:  SoLuong);
      listproduct.add(p);
      }

    void checkProduct() async {
      if (categlory != "none") {
        for(int i=0;i<list.length;i++){
          if(list[i].category!=categlory){
            list.removeAt(i);
            i--;
          }
        }
      }
    }
    double thanhtoan() {
      double sum=0.0;
      for(int i=0;i<listCart.length;i++){
        sum+=listCart[i].price*listCart[i].SoLuong.toDouble();
      }
      return sum;
    }
}