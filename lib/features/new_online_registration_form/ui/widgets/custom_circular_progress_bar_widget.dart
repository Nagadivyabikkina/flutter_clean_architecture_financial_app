import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'REGISTRATION CONFIRMATION',
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
              Container(
                  child: CircularProgressIndicator(strokeWidth: 3),
                  width: 32,
                  height: 32),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text('Please wait data is loading....',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ])));
  }
}
