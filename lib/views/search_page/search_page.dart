import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Query',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {},
            icon: Icon(EvaIcons.search),
            label: Text('Search'),
          )
        ],
      ),
    );
  }
}
