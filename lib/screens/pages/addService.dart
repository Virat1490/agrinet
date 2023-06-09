import 'dart:io';

import 'package:AgriNet/providers/imgProvider.dart';
import 'package:AgriNet/screens/pages/addImageService.dart';
import 'package:AgriNet/screens/pages/serviceListing.dart';
import 'package:AgriNet/screens/pages/success.dart';
import 'package:AgriNet/widget/addImageCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/users.dart';
import '../../providers/services_provider.dart';
import '../../services/firebase_api_methods.dart';
import 'addImageFarm.dart';

class AddService extends StatefulWidget {
  AddService({Key key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  void initState () {
    super.initState();
    _asyncMethod();
  }

  @override
  void dispose() {
    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
    imgProvider.imageUrlList.clear();
    super.dispose();
  }

  List<String> catList=[];
  Map<String, dynamic> CategoryList;
  String categoryValue = '';
  String unitValue;
  String subCategoryValue;
  List<String> subCategory;
  List<String> _tempList=[];
  List<String> priceUnit;
  _asyncMethod() async {
    DocumentSnapshot categorySnapShot =
    await FirebaseFirestore.instance
        .collection('Category')
        .doc('serviceCategory')
        .get();

    CategoryList = (categorySnapShot.data()as Map<String, dynamic>)['serviceCategory'];

    catList = CategoryList.keys.toList();
    categoryValue = catList[0];
    print(CategoryList);
    print(catList);

   DocumentSnapshot priceUnitSnapShot =
    await FirebaseFirestore.instance
        .collection('Category')
        .doc('servicePriceUnit')
        .get();

   priceUnit = List.from(priceUnitSnapShot.get("Units"));
    unitValue=priceUnit[0];
    //priceUnit=['Hour','cvd','ddd'];

    setState((){});
  }

  _newGetList() async {
    _tempList=[];
    CategoryList[categoryValue].forEach((result){
      _tempList.add(result);
    });
    setState(() {
      subCategory=_tempList;
      subCategoryValue=null;
    });
  }
  List<String> imageUrlList=["https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2Fnoimage.png?alt=media&token=47ee7a64-0059-4527-a72f-3b983957d887"];
  bool circular = false;
  //PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _servicename = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _equipmentDetail= TextEditingController();
  //TextEditingController _no_of_service= TextEditingController();
  TextEditingController _description= TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController distric= TextEditingController();
  TextEditingController state= TextEditingController();
  TextEditingController pincode= TextEditingController();
  //final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
    return Scaffold(
      appBar: DefaultAppBar(title: 'Add New Service'),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // imageProfile(),
            AddImageCard(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            categoryTextField(),
            SizedBox(
              height: 20,
            ),
            subCategoryTextField(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: priceField()),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: priceUnitTextField()),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            equipmentDetailsField(),
            SizedBox(
              height: 20,
            ),
            descriptionTextField(),
            SizedBox(
              height: 20,
            ),
            namTextField(locality,"Locality"),
            SizedBox(
              height: 20,
            ),
            namTextField(distric,"Distric"),
            SizedBox(
              height: 20,
            ),
            namTextField(state,"State"),
            SizedBox(
              height: 20,
            ),
            numberTextField(pincode,"Pincode"),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {

                if (_globalkey.currentState.validate()) {
                  setState(() {
                    circular = true;
                  });
                  ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
                await servicesProvider.sp_addservice(user.uid,_servicename.text,categoryValue, subCategoryValue,
                      _price.text,unitValue, _description.text,
                    imgProvider.imageUrlList.length>0?imgProvider.imageUrlList:imageUrlList,
                    _equipmentDetail.text,servicesProvider.serviceProvModel,
                    locality.text,
                    distric.text,state.text,pincode.text
                ).then((value) => {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>Success(
                          onPressed: () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => ServiceListing())),
                          emptyMsg: "Successful ",
                          subTitleText: 'Your Service Addedd Successfuly ' ,
                        ),
                      )
                  ),
                     /*Navigator.of(context)
                    ..pop()*/
                  });

                }
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namTextField(TextEditingController name,String labelText) {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value.isEmpty) return "Field can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.agriculture,
        //   color: Colors.green,
        // ),
        labelText: labelText,
        // helperText: "Name can't be empty",
      ),
    );
  }






  Widget numberTextField(TextEditingController phone_no,String labelText) {
    return TextFormField(
      controller: phone_no,
      keyboardType:TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "Field can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: labelText,
        //helperText: "Enter in digits",

      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _servicename,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.agriculture,
          color: Colors.green,
        ),
        labelText: "Service Name",
        helperText: "Name can't be empty",
      ),
    );
  }


  Widget priceField() {
    return TextFormField(
      controller: _price,
      keyboardType:TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "price can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.attach_money,
          color: Colors.green,
        ),
        labelText: "Pricing",
       // helperText: "Provide price of single service ",

      ),
    );
  }

  Widget categoryTextField() {
    return DropdownButtonFormField(
      value: categoryValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          categoryValue = newValue;
          _newGetList();
        });
      },
      items: catList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget subCategoryTextField() {
    return DropdownButtonFormField(
      value: subCategoryValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          subCategoryValue = newValue;
        });
      },
      items: subCategory?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })?.toList(),
    );
  }

  Widget priceUnitTextField() {
    return DropdownButtonFormField(
      value: unitValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        /*prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),*/
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          unitValue = newValue;
        });
      },
      items: priceUnit?.map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      })?.toList()??
          [],
    );
  }


  Widget equipmentDetailsField() {
    return TextFormField(
      controller: _equipmentDetail,
      validator: (value) {
        if (value.isEmpty) return "About service";

        return null;
      },
      maxLines: 2,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        labelText: "Equipment Detail",
      ),
    );
  }

  Widget descriptionTextField() {
    return TextFormField(
      controller: _description,
      validator: (value) {
        if (value.isEmpty) return "About service";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        labelText: "Description",

      ),
    );
  }
}