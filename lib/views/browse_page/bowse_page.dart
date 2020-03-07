import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartlab_mobile_frontend/views/widgets/rounded_square_card.dart';

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, __) => RoundedSquareCard(
        leading: Container(
          color: Theme.of(context).accentColor,
          child: Icon(
            EvaIcons.code,
            color: Colors.white,
            size: 32,
          ),
        ),
        height: 64,
        title: 'Embeded Systems Lab',
        content: AutoSizeText(
            'Lorem Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
            maxLines: 3),
        onTap: () {},
      ),
    );
  }
}
