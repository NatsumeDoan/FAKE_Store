import 'package:flutter/material.dart';
import 'package:form_login/product_page.dart';
import 'package:form_login/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductProvider())
      ],
      child: MaterialApp(
        home:productList_page(),
      ),
    )
  );
}

