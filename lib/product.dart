import 'package:flutter/material.dart';
import 'package:form_login/provider/product_provider.dart';
import 'package:provider/provider.dart';
class product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return cartpage();
  }
}
class cartpage extends State<product>{
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(color: Colors.black12)
                              )
                          )
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                          child: Row(
                            children: [
                              Icon(Icons.home)
                            ],
                          ))),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ...pp.listproduct.map((e){
                    return
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 500,
                          height: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(e.image??"", height: 200,)),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.title??"",maxLines: 3,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.deseription??"",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text("\$" + e.price.toString(),style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 170,
                                      child: ElevatedButton(
                                          style: ButtonStyle(

                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(24.0),

                                                  )
                                              )
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              setState(() {
                                                pp.addtocart(e.id, e.title,e.price, e.deseription, e.category, e.image, e.SoLuong);
                                              });
                                            });

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5,right: 5,top: 15,bottom: 15),
                                            child: Row(
                                              children: [
                                                Icon(Icons.shopping_cart),
                                                SizedBox(width: 20,),
                                                Text("Add to cart",style:
                                                TextStyle(
                                                    fontSize: 16
                                                ),),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      );
                  }).toList()
                ],
              ),
            ),

          ],
        )
    );
  }
}

