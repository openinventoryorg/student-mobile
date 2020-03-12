/// Lab page with item information on the lab.
///
/// Users can pick items to put in the cart and then request.
library view_page_lab;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openinventory_student_app/views/widgets/smart_app_bar.dart';

class LabPage extends StatelessWidget {
  final String id;

  const LabPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: 'SmartLab',
        subtitle: 'Smart Inventory System',
      ),
      body: ListView(
        children: <Widget>[
          labItemCard(context),
          labItemCard(context),
          labItemCard(context),
          labItemCard(context),
          labItemCard(context),
          labItemCard(context),
          labItemCard(context),
        ],
      ),
    );
  }

  Widget labItemCard(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 48,
        width: 48,
        child: Icon(Icons.code, color: Colors.white),
      ),
      trailing: Icon(Icons.check),
      title: Text(
        'Lab Item Name',
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text('Unavailable'),
      onTap: () {},
    );
  }
}
