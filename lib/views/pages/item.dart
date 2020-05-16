import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/item.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:openinventory_student_app/views/helpers/handled_builder.dart';

class ItemPage extends StatelessWidget {
  final String id;

  const ItemPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Information'),
        centerTitle: true,
      ),
      body: HandledBuilder<ItemResponse>(
        fetch: () => ApiController.of(context).item(id),
        builder: (context, item) {
          return ListView(
            children: <Widget>[
              if (item.itemSet.image != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.network(
                    '$CLOUDINARY_URL/${item.itemSet.image}',
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                ),
              Container(
                  padding: EdgeInsets.all(12),
                  color: AppColors.colorB,
                  child: Column(
                    children: <Widget>[
                      Text(
                        Helpers.capitalize(item.itemSet.title),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Product Name',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  )),
              ListTile(
                title: Text(
                  item.serialNumber,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text('Serial Number'),
                leading: Icon(LineIcons.barcode),
              ),
              Divider(),
              for (var attrib in item.itemAttributes)
                ListTile(
                  leading: Icon(LineIcons.object_ungroup),
                  title: Wrap(
                    children: <Widget>[
                      Text(
                        Helpers.capitalize(attrib.key),
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 8),
                      Text(attrib.value)
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
