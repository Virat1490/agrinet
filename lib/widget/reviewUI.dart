import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/reviewModal.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

class ReviewUI extends StatelessWidget {
  //final String image, name, date, comment;
  //final double rating;
  final ReviewModal serviceReview;
  final Function onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    Key key,
    this.serviceReview,
    this.onTap,
    this.isLess,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(serviceReview.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(44.0),
                ),
              ),
              Expanded(
                child: Text(
                  serviceReview.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: serviceReview.rating,
                isReadOnly: true,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              SizedBox(width: kFixPadding),
              Text(
                DateFormat.yMMMMd('en_US').format(serviceReview.createOn)
                ,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
              serviceReview.comment,
              style: TextStyle(
                fontSize: 18.0,
                color: kLightColor,
              ),
            )
                : Text(
              serviceReview.comment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                color: kLightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}