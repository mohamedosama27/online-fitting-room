import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/cloth_details.dart';

class HomeItem extends StatelessWidget {
  String title;
  String imageName;
  String price;
  HomeItem({this.imageName, this.title, this.price});
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
                        itemName: title,
                        itemImage: imageName,
                        itemPrice: price)));
          },
          child: Image.network(this.imageName),
        ),
        footer: GridTileBar(
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
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
