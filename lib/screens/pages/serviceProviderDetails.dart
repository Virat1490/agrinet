import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/src/rendering/box.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceProviderDetails extends StatefulWidget {
  final Service service;
  ServiceProviderDetails({Key key,@required this.service,}) : super(key: key);
  @override
  _ServiceProviderDetailsState createState() => _ServiceProviderDetailsState();
}
class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  List _services = [];
  static List<String> servicename=['POULTRY SERVICES','CROP HARVESTING','SOIL PREPARATION','HORTICULTURE SERVICES','MUSHROOM FARMING SERVICES'];
  List a=["https://animalagalliance.org/wp-content/uploads/2019/10/cropped-Untitled-design-2-560x400.png",
    "https://previews.123rf.com/images/mironovm/mironovm1707/mironovm170700013/81933875-combine-machine-is-harvesting-oats-on-farm-field-combine-harvester-working-on-a-wheat-field-combine-.jpg",
    "https://assets.siccode.com/i-s-b/sic-code-071-soil-preparation-services.jpg",
    "https://vinspirer.com/images/uploads/232dc9c564ed019ec63997bd04aa89c8.jpg",
    "https://2.wlimg.com/product_images/bc-full/2019/8/4863773/mushroom-cultivation-training-1564991173-5031789.jpeg"];


  @override
  Widget build(BuildContext context) {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.spFilteredserviceSnapShot(widget.service.serv_prov_id);
    return Scaffold(
        appBar:DefaultAppBar(title: "Service Provider Detail"),

        body:SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,


                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Image(image:NetworkImage("https://media.istockphoto.com/photos/tractor-cultivating-field-at-spring-picture-id543212762?k=20&m=543212762&s=612x612&w=0&h=3x8yNlzSApOGoZyPZl4cx_ioPLAna-AXt8SvkildxRo="),


                      ),

                      SizedBox(height:20),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      //'GREEN TRAC FARM SERVICES',
                                      widget.service.spName,
                                      style:TextStyle(
                                        fontSize: 20,
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,

                                      ),
                                    ),

                                  ),


                                ],

                              ),
                            ),


                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      //SizedBox(height:20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Column(
                                children: <Widget>[

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Name',
                                        style: TextStyle(
                                            color: Colors.blueGrey, fontSize: 18.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        widget.service.spName ,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  //SizedBox(height:20),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Location ' ,
                                        style: TextStyle(
                                            color: Colors.blueGrey, fontSize: 18.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Uttar Pradesh, India',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  //SizedBox(height:20),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Phone ',
                                        style: TextStyle(
                                            color: Colors.blueGrey, fontSize: 18.0)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        //'7865456789',
                                        widget.service.phone_number ,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height:5),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,

                              child: Container(
                                child: Column(
                                  children: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        const Divider(
                                          color: Colors.grey,
                                          height: 20,
                                          thickness: 2,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        /* ElevatedButton.icon(
                    onPressed: () {},

                    icon: Icon( // <-- Icon
                      Icons.star,
                      size: 11.0,
                    ),
                    label: Text('Ratings'),

                  ),*/
                                        //SizedBox(width: 100),

                                        ElevatedButton.icon(
                                          onPressed: () {
                                            String telephoneNumber = widget.service.phone_number;
                                            String telephoneUrl = "tel:$telephoneNumber";
                                            launchUrl (Uri.parse(telephoneUrl));
                                          },
                                          icon: Icon( // <-- Icon
                                            Icons.phone,
                                            size: 11.0,
                                          ),
                                          label: Text('Contact'),

                                        ),

                                      ],
                                    )
                                  ],
                                ),

                              ),
                            ),
                          ]
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(height:20),


                      Flexible(

                          child: Consumer<ServicesProvider>(
                            builder: (context, servicesProvider, _) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,

                                  itemBuilder:(BuildContext ctx,int index){
                                    return Padding(
                                        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),


                                        child:Card(


                                          elevation:20,
                                          //shape:Border.all(
                                          //    width:6,
                                          //color:Colors.blue.shade50),*/

                                          child:Stack(
                                            children:<Widget>[

                                              Image.network(servicesProvider.spFilterServiceList[index].imageUrl[0],


                                              ),

                                              Positioned(
                                                  bottom:16,
                                                  right:16,
                                                  left:16,
                                                  child:Text(
                                                      servicesProvider.spFilterServiceList[index].name,
                                                      style:TextStyle(
                                                          fontWeight:  FontWeight.bold,
                                                          color:Colors.blue,fontSize:18
                                                      )
                                                  )
                                              ),

                                            ],

                                          ),


                                        )
                                    );
                                  },itemCount:servicesProvider.spFilterServiceList.length);
                            }
                          )


                      ),

                      //




                    ])
            )));
  }



}