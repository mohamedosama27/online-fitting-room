import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/cart.dart';
import 'package:virtual_fitting_room/provider/cloth.dart';
import 'package:virtual_fitting_room/screens/cloth_details.dart';

class ClothesItem extends StatelessWidget {
  String title;
  String imageName;
  String price;
  Cloth item;
  ClothesItem({this.imageName, this.title, this.price, this.item});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: GridTile(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClothDetails(
                                itemImage: imageName,
                                itemName: title,
                                itemPrice: price,
                              )));
                },
                child: Image.network(imageName)),
            footer: Container(
              height: 40,
              child: Consumer<cart>(builder: (context, cart, child) {
                return GridTileBar(
                  backgroundColor: Colors.black87,
                  title: Text(
                    this.title,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    this.price,
                    textAlign: TextAlign.center,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                    ),
                    onPressed: () {
                      cart.add(item);
                    },
                    color: Theme.of(context).accentColor,
                  ),
                );
              }),
            )));
  }
}
