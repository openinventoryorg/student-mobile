import 'package:flutter/material.dart';

class LendForm extends StatelessWidget {
  final String id;

  const LendForm({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          //Pass
        ],
      ),
    );
  }
}
