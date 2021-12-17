import 'dart:developer';
import 'package:ecommercestore/repositories/shop_repo.dart';
import 'package:ecommercestore/models/ui/shop.dart';
import 'package:flutter/material.dart';

class ShopDetails extends StatelessWidget {
    String title = 'Shop Details';//static final

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: MainPage(title: title),
  );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final shopRepo = ShopRepo.instance;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: StreamBuilder<List<Shop>>(
      initialData: const [],
      stream: shopRepo.getShopListStream(),
      builder: (context, snapshot) {
        log(snapshot.data?.toString() ?? 'null');
        if(snapshot.data == null){
          return const SizedBox.shrink();
        }
        return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (context, index) {
          return buildImageInteractionCard(snapshot.data![index]);
        });
      } ,
    ),
  );


  Widget buildImageInteractionCard(Shop shop) => Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Ink.image(
              image: NetworkImage(
                shop.shopPicUrl ?? 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
              ),
              child: InkWell(
                onTap: () {},
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child:
              Text(
                shop.shopId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16).copyWith(bottom: 0),
          child: Text(
            shop.address,
            style: TextStyle(fontSize: 16),
          ),
        ),

      ],
    ),
  );
}