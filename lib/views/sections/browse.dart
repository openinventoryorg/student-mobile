/// Home page section in which users can browse labs.
library view_section_browse;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_student_app/api/responses/lab.dart';
import 'package:openinventory_student_app/constants.dart';
import 'package:openinventory_student_app/controllers/api.dart';
import 'package:openinventory_student_app/helpers.dart';
import 'package:openinventory_student_app/routes/router.dart';
import 'package:openinventory_student_app/views/colors.dart';
import 'package:openinventory_student_app/views/helpers/handled_builder.dart';

class BrowseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HandledBuilder<List<LabResponse>>(
      fetch: ApiController.of(context).labList,
      builder: (context, data) {
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => LabCard(lab: data[index]),
        );
      },
    );
  }
}

class LabCard extends StatelessWidget {
  final LabResponse lab;

  const LabCard({Key key, @required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () => onLabCardPress(context),
        child: GridTile(
          child: Container(
            color: AppColors.colorB,
            child: lab.image == null
                ? Icon(LineIcons.laptop, size: 56)
                : Image.network('$CLOUDINARY_URL/${lab.image}',
                    fit: BoxFit.cover),
          ),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                AutoSizeText(
                  Helpers.capitalize(lab.title),
                  style: _LabCardStyles.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                AutoSizeText(
                  Helpers.capitalize(lab.subtitle),
                  style: _LabCardStyles.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLabCardPress(BuildContext context) {
    AppRouter.navigate(context, '/home/lab/${lab.id}');
  }
}

abstract class _LabCardStyles {
  static TextStyle get title => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get subtitle => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      );
}
