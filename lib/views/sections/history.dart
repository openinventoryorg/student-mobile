import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/history.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/helpers/handled_builder.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HandledBuilder<List<HistoryResponse>>(
      fetch: ApiController.of(context).getHistory,
      builder: (context, data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, i) => RequestCard(
            request: data[data.length - i - 1],
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
    bool hasAllReturned =
        request.requestItems.every((element) => element.status == 'RETURNED');

    return ExpansionTile(
      key: Key(request.lab.id),
      title: Text(
        Helpers.capitalize(request.lab.title),
        style: TextStyle(fontWeight: FontWeight.w900),
      ),
      leading: CircleAvatar(
        backgroundColor:
            hasAllReturned ? Colors.grey : Theme.of(context).accentColor,
        child: Text(
          'x${request.requestItems.length}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      subtitle: Text(
          "${request.capitalizedStatus} ${timeago.format(request.updatedAt)}"),
      trailing: Icon(LineIcons.angle_down),
      children: <Widget>[
        for (var request in request.requestItems)
          ListTile(
            leading: AspectRatio(
              aspectRatio: 1,
              child: request.item.itemSet.image == null
                  ? Container(color: Theme.of(context).primaryColor)
                  : Image.network(
                      '$CLOUDINARY_URL/${request.item.itemSet.image}',
                      fit: BoxFit.cover,
                    ),
            ),
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
