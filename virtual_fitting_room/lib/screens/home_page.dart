import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/screens/human_model.dart';
import 'package:virtual_fitting_room/widgets/home_item.dart';
import 'package:virtual_fitting_room/widgets/painted_line.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _current = 0;
  List<String> imgNames = ['bluejeans.jpg', 'jacket.jpg', 'shirt.jpg'];
  List<String> itemNames = ["Blue Jeans", "Jacket", "Shirt"];
  List<String> itemPrices = ['200', '300', '100'];
  List<Widget> itemsList = new List<Widget>();

  @override
  void initState() {
    for (var i = 0; i < itemNames.length; i++) {
      itemsList.add(Container(
        child: HomeItem(
            imageName: imgNames[i], title: itemNames[i], price: itemPrices[i]),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Container(
        width: _width * 0.87,
        margin: EdgeInsets.only(top: _height * 0.04, bottom: _height * 0.02),
        child: Column(children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Home",
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
            painter: CurvePainter(Color(0xFF9F140B), Color(0x269F140B), 3),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
          Container(
            child: CarouselSlider(
              items: itemsList,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: _height * 0.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: itemsList.map((url) {
              int index = itemsList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          RaisedButton(
            child: Text('Model', style: TextStyle(fontSize: 24)),
            onPressed: () async => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HumanModel()))
            },
            color: Color(0xFF9F140B),
            textColor: Colors.white,
          )
        ]));
  }
}
