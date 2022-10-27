import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_login/cart_page.dart';
import 'package:form_login/product.dart';
import 'package:form_login/provider/product_provider.dart';
import 'package:provider/provider.dart';
class productList_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListPage();
  }
}
class ProductListPage extends State<productList_page>{
  //ProductListPage({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool grid = true;
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    if(pp.list.isEmpty)
      pp.getList();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                label: Text("Tìm kiếm sản phẩm"),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                hintText: "vui lòng nhập tên sản phẩm tìm kiếm",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                prefixIcon: Icon(Icons.search)
                            ),
                          )
                        ],
                      )
                  ),
                ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => cart_page()),
                     );
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                        child: Row(
                          children: [
                            Text("Giỏ hàng "),
                            Icon(Icons.shopping_cart)
                          ],
                        ))),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...pp.list2.map((e){
                  return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){
                          setState((){
                            pp.categlory = e.toString();
                            pp.checkProduct();
                          });
                        }, child: Text(e)),
                      )
                  );
                }).toList()
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(

                    ),
                    onPressed: () {
                      bool isGrid = false;
                      pp.show(isGrid);
                    },
                    child: Row(
                          children: [
                            Icon(Icons.list)
                          ],
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(

                    ),
                    onPressed: (){
                      bool isGrid = true;
                      pp.show(isGrid);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.grid_on)
                      ],
                    )),
              ),
            ],
          ),
          Expanded(
            child: (pp.showGrid)
                ?GridView.count(
              crossAxisCount: 2,
              children: [
                ...pp.list.map((e){
                  return
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          ),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white10),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => product()),
                            );
                            setState(() {
                              pp.product(e.id, e.title,e.price, e.deseription, e.category, e.image, e.SoLuong);
                            });
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.network(e.image??"", width: 50, height: 70,)
                                ),
                                Text(e.title??"",maxLines: 3, style: TextStyle( fontWeight: FontWeight.bold)),
                                Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("\$" + e.price.toString(),style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),),),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                  child: Container(
                                    width: 101,
                                    child: ElevatedButton(
                                        style: ButtonStyle(

                                        ),
                                        onPressed: (){
                                          setState(() {
                                            pp.addtocart(e.id, e.title,e.price, e.deseription, e.category, e.image, e.SoLuong);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text("Add to cart")
                                          ],
                                        )),
                                  ),
                                ),
                              ]
                          ),
                        ),

                      ),
                    );
                }).toList()
              ],

            )
                :ListView(
              scrollDirection: Axis.vertical,
              children: [
                ...pp.list.map((e){
                  return
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          ),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white10),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => product()),
                            );
                            setState(() {
                              pp.product(e.id, e.title,e.price, e.deseription, e.category, e.image, e.SoLuong);
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(e.image??"", width: 130, height: 150,)),
                                  Container(
                                      width: 150,
                                      child: Text(e.title??"",textAlign: TextAlign.justify,style: TextStyle( fontWeight: FontWeight.bold),)),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                                            child: Text("\$" + e.price.toString(),style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            ),),),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                                          child: Container(
                                            width: 101,
                                            child: ElevatedButton(
                                                style: ButtonStyle(

                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    pp.addtocart(e.id, e.title,e.price, e.deseription, e.category, e.image, e.SoLuong);
                                                  });

                                                },
                                                child: Row(
                                                  children: [
                                                    Text("Add to cart")
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
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
