import 'package:AgriNet/screens/pages/service_catalogue.dart';
import 'package:flutter/material.dart';

class FarmHome extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _FarmHomeState createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[


        Positioned(
          bottom:20,
          child:Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
              child: Container(
                color: Colors.black26,
                child: Row(
                  children:<Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(

                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.schema, size: 44.0 ,),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
                            child: Text(
                              "Join",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(

                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => ServiceCatalogue(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.category, size: 44.0 ,),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
                            child: Text(
                              "Catalogue",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(

                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.assignment, size: 44.0 ,),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
                            child: Text(
                              "Booking",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(12.0, 2.0, 2.0, 2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(

                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.favorite, size: 44.0 ,),
                              //label: Text('Home')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 2.0, 2.0, 2.0),
                            child: Text(
                              "Fav",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}