import 'package:flutter/material.dart';

import './lab_card.dart';

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        LabCard(),
        LabCard(),
        LabCard(),
        LabCard(),
        LabCard(),
      ],
    );
  }
}
