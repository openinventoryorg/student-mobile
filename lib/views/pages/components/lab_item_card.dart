import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/pages/components/item_image.dart';

class LabItemCard extends StatelessWidget {
  const LabItemCard({
    Key key,
    @required this.context,
    @required this.labItem,
    @required this.labId,
  }) : super(key: key);

  final BuildContext context;
  final LabItemResponse labItem;
  final String labId;

  @override
  Widget build(BuildContext context) {
    bool isPickedUp = CartController.listenOf(context)
        .isInCart(labId, CartItem.fromLabItemResponse(labItem));

    return ListTile(
      leading: Container(
        padding: EdgeInsets.only(left: 8),
        color: isPickedUp ? Colors.green : Colors.red,
        child: ItemImage(
          id: labItem.id,
          image: labItem.itemSet.image,
        ),
      ),
      trailing: Hero(
        tag: '${labItem.id}-button',
        child: Material(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: IconButton(
              color: Colors.white,
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child:
                    isPickedUp ? Icon(LineIcons.minus) : Icon(LineIcons.plus),
              ),
              onPressed: () {
                var cart = CartController.of(context);
                var cartItem = CartItem.fromLabItemResponse(labItem);
                if (isPickedUp) {
                  cart.removeItem(labId, cartItem);
                } else {
                  cart.addItem(labId, cartItem);
                }
              },
            ),
          ),
        ),
      ),
      title: Text(
        Helpers.capitalize(labItem.itemSet.title),
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(labItem.serialNumber),
      onTap: () {
        AppRouter.navigate(context, '/item/${labItem.id}');
      },
    );
  }
}
