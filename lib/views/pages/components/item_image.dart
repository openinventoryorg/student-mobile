import 'package:flutter/material.dart';
import 'package:openinventory_student_app/constants.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({
    Key key,
    @required this.id,
    @required this.image,
    this.tagSuffix = '',
  }) : super(key: key);

  final String id;
  final String image;
  final String tagSuffix;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$id-image-$tagSuffix',
      child: image == null
          ? Container(
              color: Theme.of(context).primaryColor,
            )
          : Image.network(
              '$CLOUDINARY_URL/$image',
              fit: BoxFit.cover,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              colorBlendMode: BlendMode.srcATop,
            ),
    );
  }
}
