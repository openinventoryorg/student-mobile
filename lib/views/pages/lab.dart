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
import 'package:openinventory_student_app/views/helpers/handled_builder.dart';
import 'package:openinventory_student_app/views/pages/components/lab_item_card.dart';

class LabPage extends StatelessWidget {
  final String id;
  final animatedListState = GlobalKey<AnimatedListState>();

  LabPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<CartItem> cartItems = CartController.listenOf(context).getCartItems(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(LineIcons.search),
            onPressed: () {
              showSearch(context: context, delegate: LabSearchDelegate(id));
            },
          )
        ],
      ),
      body: HandledBuilder<List<LabItemResponse>>(
        fetch: () => ApiController.of(context).labItemsList(id),
        builder: (context, data) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => LabItemCard(
                    context: context,
                    labItem: data[index],
                    labId: id,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: cartItems.isNotEmpty
          ? FloatingActionButton.extended(
              icon: Icon(LineIcons.check),
              label: Text('Continue to Submit (x${cartItems.length})'),
              backgroundColor: AppColors.colorD,
              onPressed: () {
                AppRouter.navigate(context, '/lend/$id');
              },
            )
          : null,
    );
  }
}

class LabSearchDelegate extends SearchDelegate {
  final String id;

  LabSearchDelegate(this.id);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(LineIcons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(LineIcons.arrow_left),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return HandledBuilder<List<LabItemResponse>>(
      fetch: () => ApiController.of(context).labItemsList(id),
      builder: (context, data) {
        var filtered = data
            .where((element) => element.itemSet.title.contains(query))
            .toList();

        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) => LabItemCard(
                  context: context,
                  labItem: filtered[index],
                  labId: id,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
