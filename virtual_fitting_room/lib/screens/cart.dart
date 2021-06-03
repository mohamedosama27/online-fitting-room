import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/cart.dart';
import 'package:virtual_fitting_room/provider/cart.dart';
import 'package:virtual_fitting_room/widgets/cart_item.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';
import 'package:virtual_fitting_room/provider/cart.dart' show cart;

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    final mycart = Provider.of<cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9F140B),
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${mycart.totalprice}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: mycart.basketitem.length,
              itemBuilder: (ctx, i) => CartItem(
                mycart.basketitem.toList()[i].id,
                mycart.basketitem.toList()[i].price,
                mycart.basketitem.toList()[i].type,
              ),
            ),
          )
        ],
      ),
    );
  }
}
