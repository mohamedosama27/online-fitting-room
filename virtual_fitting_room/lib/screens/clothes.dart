import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/cloth.dart';
import 'package:virtual_fitting_room/widgets/clothes_item.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';

class Clothes extends StatefulWidget {
  Clothes({Key key}) : super(key: key);

  @override
  ClothesState createState() => ClothesState();
}

class ClothesState extends State<Clothes> {
  @override
  void initState() {
    Provider.of<cloth>(context, listen: false).fetchCloth();
    super.initState();
  }

  Widget build(BuildContext context) {
    List<Cloth> clothList = Provider.of<cloth>(context, listen: true).clothlist;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.topCenter,
        width: _width * 0.87,
        margin: EdgeInsets.only(top: _height * 0.04, bottom: _height * 0.03),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clothes",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF9F140B),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: _height * 0.025,
              ),
              CustomPaint(
                size: Size(_width * 0.87, _height * 0.006),
                painter: CurvePainter(Color(0xFF9F140B), Color(0x269F140B), 2),
              ),
              SizedBox(
                height: _height * 0.025,
              ),
              Container(
                  height: _height * 0.05,
                  child: RaisedButton(
                    child: GridTileBar(
                      title: Text('Filter', style: TextStyle(fontSize: 24)),
                      trailing: Icon(
                        Icons.filter_alt,
                      ),
                    ),
                    onPressed: () => {},
                    color: Color(0xFF9F140B),
                    textColor: Colors.white,
                  )),
              SizedBox(
                height: _height * 0.025,
              ),
              Flexible(
                  child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: clothList.length,
                itemBuilder: (ctx, index) {
                  return ClothesItem(
                      imageName: clothList[index].frontimage,
                      title: clothList[index].type,
                      price: clothList[index].price,
                      item: clothList[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ))
            ]));
  }
}
