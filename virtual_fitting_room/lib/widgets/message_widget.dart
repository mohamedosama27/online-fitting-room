import 'package:flutter/material.dart';

class MessageBoxModal {
  MessageBoxModal(this.context);

  final BuildContext context;

  void showMessageBoxModal([String text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.white,
              content: LoadingIndicator(
                  text: text,
                  callback: hideOpenDialog,
              ),
            )
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget{
  LoadingIndicator({this.text = '',this.callback});

  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getHeading(),
              _getIcon(),
              _getText(displayedText),
              _getButton()
            ]
        )
    );
  }

  Widget _getHeading() {
    return
      Padding(
          child: Text(
            'Failed',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.all(5)
      );
  }
  Widget _getIcon() {
    return
      Padding(
          child: Icon(
            Icons.warning_amber_outlined,
            size: 100,
            color: Colors.yellow,
          ),
          padding: EdgeInsets.all(5)
      );
  }

  Widget _getText(String displayedText) {
    return Padding(
        child: Text(
      displayedText,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
      textAlign: TextAlign.center,
    ),
        padding: EdgeInsets.all(10)

    );
  }
  Widget _getButton() {
    return RaisedButton(
      onPressed: () => callback(),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(5.0),
          side: BorderSide(
              color: Color(0xFF71A411))),
      color: Color(0xFF71A411),
      child: Text(
        "OK",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}