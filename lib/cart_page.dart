import 'package:flutter/material.dart';
import 'package:form_login/provider/product_provider.dart';
import 'package:provider/provider.dart';
class cart_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return cartpage();
  }
}
class cartpage extends State<cart_page>{
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    if(pp.listCart.isEmpty)
      pp.getList();
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
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  ...pp.listCart.map((e){
                    return
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(e.image??"", width: 130, height: 150,)),
                                  Column(
                                    children: [
                                      Container(
                                          width: 200,
                                          child: Text(e.title??"",maxLines:1,overflow: TextOverflow.ellipsis ,style: TextStyle( fontWeight: FontWeight.bold),)),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(onPressed: (){
                                              setState(() {
                                                e.minus(pp.listCart);
                                              });
                                            }, child: Text("-")),
                                            Container(
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                child: Text(e.SoLuong.toString(), textAlign: TextAlign.center,),
                                              ),
                                            ),
                                            ElevatedButton(onPressed: (){
                                              setState(() {
                                                e.add();
                                              });
                                            }, child: Text("+")),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                                          child: Text("\$" +(e.price*e.SoLuong.toDouble()).toString()??"",style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ))
                                      ),

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),

                        ),
                      );
                  }).toList()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total:  \$" +pp.thanhtoan().toString(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Container(
              width: 400,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              side: BorderSide(color: Colors.black12)
                          )
                      )
                  ),
                  onPressed: (){
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.paypal),
                          Text("Thanh toán "),
                        ],
                      ))),
            ),
          ],
        )
    );
  }
}

