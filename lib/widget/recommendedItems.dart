import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';

class RecommendedItems extends StatelessWidget {
  final double height,  rating, top, bottom, left, right, radius;
  //final String image, title,price,;
 // final int sale;
  final Service service;
  const RecommendedItems({
    Key key,
    this.height,
    //this.image,
    //this.price,
    this.rating,
    //this.title,
    //this.sale,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.radius,
    this.service
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: kAccentColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(service.imageUrl[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: kLessPadding,
              left: kLessPadding,
            ),
            child: Text(
              service.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kDarkColor.withOpacity(0.8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: kLessPadding,
              left: kLessPadding,
            ),
            child: Text("Rs ${service.price}/${service.priceUnit}"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: kLessPadding,
              left: kLessPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: rating.toString(),
                          style: TextStyle(
                            color: kDarkColor.withOpacity(0.4),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Icon(
                            Icons.star,
                            size: 16.0,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               /* Text(
                  "${sale.toString()} Sale",
                  style: TextStyle(
                    color: kDarkColor.withOpacity(0.4),
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}