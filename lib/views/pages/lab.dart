/// Lab page with item information on the lab.
///
/// Users can pick items to put in the cart and then request.
library view_page_lab;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:openinventory_student_app/views/pages/components/item_image.dart';
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

          var cartItems =
              CartController.listenOf(context).getCartItems(id).toList();

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
              Container(
                height: 86,
                color: AppColors.colorB,
                child: ImplicitlyAnimatedList<CartItem>(
                  scrollDirection: Axis.horizontal,
                  items: cartItems,
                  areItemsTheSame: (a, b) => a.id == b.id,
                  insertDuration: Duration(milliseconds: 300),
                  removeDuration: Duration(milliseconds: 300),
                  itemBuilder: (context, animation, item, index) {
                    return SizeFadeTransition(
                      sizeFraction: 0.7,
                      curve: Curves.easeInOut,
                      animation: animation,
                      child: LabCartItem(cartItem: item),
                    );
                  },
                  removeItemBuilder: (context, animation, oldItem) {
                    return SizeFadeTransition(
                      sizeFraction: 0.7,
                      curve: Curves.easeOut,
                      animation: animation,
                      child: LabCartItem(cartItem: oldItem),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorE,
        child: Icon(
          LineIcons.check_square_o,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}

class LabCartItem extends StatelessWidget {
  final CartItem cartItem;

  const LabCartItem({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.navigate(context, '/item/${cartItem.id}');
      },
      child: Container(
        key: Key(cartItem.id),
        padding: EdgeInsets.all(8),
        child: Tooltip(
          message: Helpers.capitalize(cartItem.title),
          child: ItemImage(
            tagSuffix: 'cart',
            id: cartItem.id,
            image: cartItem.image,
          ),
        ),
      ),
    );
  }
}
