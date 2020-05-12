import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/requests/lend.dart';
import 'package:openinventory_student_app/api/responses/supervisor.dart';
import 'package:openinventory_student_app/api/responses/supervisorlist.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/controllers/cart.dart';
import 'package:openinventory_student_app/controllers/token.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';

class LendForm extends StatefulWidget {
  final String id;

  const LendForm({Key key, this.id}) : super(key: key);

  @override
  _LendFormState createState() => _LendFormState();
}

class _LendFormState extends State<LendForm> {
  TextEditingController reasonController;
  SupervisorResponse supervisor;

  @override
  void initState() {
    reasonController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartItems = CartController.listenOf(context).getCartItems(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        centerTitle: true,
      ),
      body: FutureBuilder<SupervisorListResponse>(
        future: ApiController.of(context).supervisorsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(LineIcons.user),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DropdownButton<SupervisorResponse>(
                              items: [
                                for (var supervisor
                                    in snapshot.data.supervisors)
                                  DropdownMenuItem(
                                    value: supervisor,
                                    child: Text(supervisor.toString()),
                                  ),
                              ],
                              onChanged: (s) => setState(() {
                                supervisor = s;
                              }),
                              value: supervisor,
                              isExpanded: true,
                              hint: Text('Supervisor'),
                              icon: Icon(LineIcons.angle_down),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: reasonController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason for Lending',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Items you chose',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              for (var cartItem in cartItems)
                ListTile(
                  leading: cartItem.image == null
                      ? Container(color: Theme.of(context).primaryColor)
                      : Image.network(
                          '$CLOUDINARY_URL/${cartItem.image}',
                          fit: BoxFit.cover,
                        ),
                  title: Text(Helpers.capitalize(cartItem.title)),
                  onTap: () {
                    AppRouter.navigate(context, '/item/${cartItem.id}');
                  },
                  trailing: Icon(LineIcons.external_link),
                ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          icon: Icon(LineIcons.cloud_upload),
          label: Text('Send the Request'),
          backgroundColor: AppColors.colorD,
          onPressed: () async {
            try {
              if (supervisor == null)
                throw Exception('Supervisor not selected');
              var request = LendRequest(
                labId: widget.id,
                itemIds: cartItems.map((e) => e.id).toList(),
                reason: reasonController.text,
                supervisorId: supervisor.id,
                userId: TokenController.of(context).user.id,
              );
              await ApiController.of(context).sendRequest(request);
              CartController.of(context).clearCart(widget.id);
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text('Request Done'),
                  contentPadding: EdgeInsets.all(24),
                  children: <Widget>[
                    Text(
                        'The Request was successfully submitted to the supervisor $supervisor.'),
                    Text(
                        'You will recieve an email once the supervisor accepts the request.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () =>
                              AppRouter.freshNavigate(context, '/home'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            } catch (err) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(err.toString()),
                backgroundColor: Colors.red,
              ));
            }
          },
        ),
      ),
    );
  }
}
