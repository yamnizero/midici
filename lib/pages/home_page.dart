import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medicine_2/network/api/url_api.dart';
import 'package:medicine_2/network/model/product_model.dart';
import 'package:medicine_2/pages/detail_product.dart';
import 'package:medicine_2/pages/search_product_page.dart';
import 'package:medicine_2/theme.dart';
import 'package:medicine_2/widget/card_category.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_2/widget/card_product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late int index;
  bool filter =false;

  //--------------------------------//
  List<CategoryWithProduct> listCategory = [];
  getCategory()async{
    listCategory.clear();
    var uriCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(uriCategory);
    if(response.statusCode == 200){
      setState(() {
        final data = jsonDecode(response.body);
        // final item;
        for(Map  item in data){
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
    }
  }
//---------------------------------//
List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var uriProduct = Uri .parse(BASEURL.getProduct);
    final response = await http.get(uriProduct);
    if(response.statusCode == 200){
      setState(() {
        final data = jsonDecode(response.body);
        for(Map product in data){
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }



  @override
  void initState() {

    super.initState();
    getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
          children: [
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Image.asset('assets/logo.png',
                 width: 155,
                 ),
                 SizedBox(height: 16,),
                 Text("Find a medicine or\nvitamins with MEDICINE",
                 style: regulerTextStyle.copyWith(fontSize: 15,color: Colors.grey),
                 ),
               ],
             ),
             IconButton(
                 onPressed: (){},
                 icon: Icon(Icons.shopping_cart_rounded,
                 color: greenColor,
                 ),
             ),
            ],
            ),
            SizedBox(height: 24,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:16,vertical:5),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color(0xffe4faf0),
                ),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(border:InputBorder.none,
                  prefixIcon: Icon(Icons.search,
                  color: Color(0xffb1d8b2),),
                    hintText: "Search medicine ...",
                    hintStyle: regulerTextStyle.copyWith(color: Color(0xffb1d8b2)),

                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text("Medicine & vitamins by Category",style: regulerTextStyle.copyWith(fontSize:16 ),),
            SizedBox(height: 24,),
            GridView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: listCategory.length,
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10
                ),
                itemBuilder: (context, i){
                  final x = listCategory[i];
                  return InkWell(
                    onTap: (){
                      setState(() {
                        index = i;
                        filter = true;
                        print("$index,$filter");
                      });
                    },
                    child: CardCategory(
                        imageCatrgory: x.image,
                        nameCatrgory: x.category,
                    ),
                  );
                }),
            SizedBox(height: 32,),
        filter ?
        index == 7
        ?Text("Feature on progress"):
        GridView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: listCategory[index].product!.length,
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16
                ),
                itemBuilder: (context, i){
                  final y = listCategory[index].product![i];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailProduct(y)));
                    },
                    child: CardProduct(
                        imageProduct: y.imageProduct,
                        nameProduct: y.nameProduct,
                        price: y.price
                    ),
                  );
                })
            :GridView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: listProduct.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16
            ),
            itemBuilder: (context, i){
              final y = listProduct[i];
              return InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailProduct(y)));
                },
                child: CardProduct(
                    imageProduct: y.imageProduct,
                    nameProduct: y.nameProduct,
                    price: y.price
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
