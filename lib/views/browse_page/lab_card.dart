import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LabCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
          child: Image.network(
            'https://blog.westmonroepartners.com/wp-content/uploads/2019/08/Lab_blog.jpg',
            fit: BoxFit.cover,
          ),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                AutoSizeText(
                  'Laboratory',
                  style: LabCardStyles.title,
                  maxLines: 1,
                ),
                AutoSizeText(
                  'Lorem ipsum sit amet del por var, si el',
                  style: LabCardStyles.subtitle,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class LabCardStyles {
  static TextStyle get title => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get subtitle => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      );
}
