import 'package:flutter/material.dart';
import 'package:virtual_fitting_room/widgets/seen_circle.dart';

class notificationsList extends StatelessWidget {
  notificationsList({
    this.title,
    this.messege,
    this.seen
  });
  bool seen;
  String title;
  String messege;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            new Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            new Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Text(
                      messege,
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: seen
                        ? Container()
                        : Center(child: CustomPaint(painter: seenPoint())),
                  )
                ],
              ),
            ),
            new Divider(
              color: Colors.black12,
              thickness: 1,
            )
          ],
        ));
  }
}