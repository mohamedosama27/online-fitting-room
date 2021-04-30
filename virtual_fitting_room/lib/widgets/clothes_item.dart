import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/cloth_details.dart';

class ClothesItem extends StatelessWidget{
  String title;
  String imageName;
  String price;
  ClothesItem({this.imageName,this.title,this.price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClothDetails()));
            },
            child: Image.asset(
              'assets/'+this.imageName,
              fit: BoxFit.cover,
            )
        ),
        footer: Container(
          height: 40,
            child:GridTileBar(
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
            onPressed: (){

            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),)
    );
  }

}