import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/laborProvider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/labourCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaborCatalog extends StatefulWidget {
  final String hirer;
  LaborCatalog({this.hirer,Key key}) : super(key: key);

  @override
  _LaborCatalogState createState() => _LaborCatalogState();
}

class _LaborCatalogState extends State<LaborCatalog> {
  @override
  Widget build(BuildContext context) {
    LaborProvider laborProvider = Provider.of<LaborProvider>(context, listen: false);
    laborProvider.getLaborSnapShot();
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(title: "Labours"),

        body:Consumer<LaborProvider>(
            builder: (context, laborProvider, _) {
              return ListView(
                //padding: EdgeInsets.all(12),
                children: [
                  Column(
                    children: <Widget>[
                      Column(
                          children: laborProvider.laborList.map((p) {
                            return LabourCard(
                              labor: p,
                              hirer: widget.hirer ,
                            );
                          }).toList()
                      ),
                    ],
                  ),
                ],
              );
            }
        )
    );
  }
}