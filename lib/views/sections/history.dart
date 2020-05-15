import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/history.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryResponse>>(
      future: ApiController.listenOf(context).getHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (_, i) => RequestCard(
            request: snapshot.data[snapshot.data.length - i - 1],
          ),
        );
      },
    );
  }
}

class RequestCard extends StatelessWidget {
  final HistoryResponse request;

  const RequestCard({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: Key(request.lab.id),
      title: Text(
        request.capitalizedStatus,
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
      leading: CircleAvatar(
        child: Text('${request.requestItems.length}'),
      ),
      subtitle: Text(timeago.format(request.updatedAt)),
      trailing: Icon(LineIcons.angle_down),
      children: <Widget>[
        for (var request in request.requestItems)
          ListTile(
            leading: request.item.itemSet.image == null
                ? Container(color: Theme.of(context).primaryColor)
                : Image.network('$CLOUDINARY_URL/${request.item.itemSet.image}',
                    fit: BoxFit.cover),
            title: Text(Helpers.capitalize(request.item.itemSet.title)),
            subtitle: Text(Helpers.capitalize(request.status)),
            trailing: Icon(LineIcons.external_link),
            onTap: () {
              AppRouter.navigate(context, '/item/${request.item.id}');
            },
          )
      ],
    );
  }
}
