import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/item.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/views/pages/components/item_image.dart';

class ItemPage extends StatefulWidget {
  final String id;

  const ItemPage({Key key, @required this.id}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  ItemResponse item;

  @override
  void initState() {
    getItem();
    super.initState();
  }

  void getItem() async {
    try {
      var data = await ApiController.of(context).item(widget.id);
      setState(() => {item = data});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: item == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  primary: true,
                  title: Text(item.capitalizedTitle),
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        ItemImage(id: widget.id, image: item.itemSet.image),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: Theme.of(context).accentColor,
                      child: ListTile(
                        leading: Icon(LineIcons.barcode, color: Colors.white),
                        title: Text(item.serialNumber,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text('Serial Number',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    for (var attrib in item.itemAttributes)
                      ListTile(
                        title: Text(attrib.value),
                        subtitle: Text(attrib.key),
                        leading: Icon(LineIcons.object_ungroup),
                      ),
                  ]),
                ),
              ],
            ),
      floatingActionButton: item == null
          ? null
          : FloatingActionButton(
              heroTag: '${widget.id}-button',
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: CartController.listenOf(context)
                        .isInCart(item.lab.id, CartItem.fromItemResponse(item))
                    ? Icon(LineIcons.minus)
                    : Icon(LineIcons.plus),
              ),
              onPressed: () {
                var cart = CartController.of(context);
                var cartItem = CartItem.fromItemResponse(item);
                if (cart.isInCart(item.lab.id, cartItem)) {
                  cart.removeItem(item.lab.id, cartItem);
                } else {
                  cart.addItem(item.lab.id, cartItem);
                }
              },
            ),
    );
  }
}
