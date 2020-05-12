/// Lab page with item information on the lab.
///
/// Users can pick items to put in the cart and then request.
library view_page_lab;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:openinventory_student_app/views/pages/components/lab_item_card.dart';

class LabPage extends StatelessWidget {
  final String id;
  final animatedListState = GlobalKey<AnimatedListState>();

  LabPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<LabItemResponse>>(
        future: ApiController.listenOf(context).labItemsList(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => LabItemCard(
                    context: context,
                    labItem: snapshot.data[index],
                    labId: id,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(LineIcons.check),
        label: Text(
            'Continue to Submit (x${CartController.listenOf(context).getCartItems(id).length})'),
        backgroundColor: AppColors.colorD,
        onPressed: () {
          AppRouter.navigate(context, '/lend/$id');
        },
      ),
    );
  }
}
