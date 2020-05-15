import 'package:flutter/material.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';

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
      leading: AspectRatio(
        aspectRatio: 1,
        child: labItem.itemSet.image == null
            ? Container(color: Theme.of(context).primaryColor)
            : Image.network(
                '$CLOUDINARY_URL/${labItem.itemSet.image}',
                fit: BoxFit.cover,
              ),
      ),
      trailing: labItem.isAvailable
          ? RaisedButton(
              textColor: Colors.white,
              color:
                  isPickedUp ? Theme.of(context).accentColor : AppColors.colorD,
              child: Text(isPickedUp ? 'Remove' : 'Add'),
              onPressed: () {
                var cart = CartController.of(context);
                var cartItem = CartItem.fromLabItemResponse(labItem);
                try {
                  if (isPickedUp) {
                    cart.removeItem(labId, cartItem);
                  } else {
                    cart.addItem(labId, cartItem);
                  }
                } catch (err) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(err.toString()),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            )
          : Text(
              'UNAVAILABLE',
              style: TextStyle(
                color: Colors.red[800],
                fontWeight: FontWeight.w600,
                fontSize: 12,
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
