import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String image;
  final String name;

  Avatar({this.size, this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.all(1),
          // width: 100,
          // height: 100,
          decoration: BoxDecoration(
            // color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: ClipOval(
              child: CachedNetworkImage(
            height: size,
            width: size,
            fit: BoxFit.cover,
            imageUrl: image ?? 'https://www.valiance.gg/images/089e0ea.png',
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: 150,
                height: 160,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
        ),
        SizedBox(
          height: 8.0,
        ),
        ClipRect(
          child: SizedBox(
            width: size,
            child: Text(
              name,
              softWrap: false,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
