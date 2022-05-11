

import 'package:AgriNet/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';


//final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
Future sp_onboarding(String uid,String name,
    String location,String phone_number,String account_holder_name,
    String account_number,String ifs_code,String bank_name,String pincode ) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('service_providers');
  return serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'name': name,
    'location': location,
    'phone_number':phone_number,
    'account_holder_name':account_holder_name,
    'account_number':account_number,
    'ifs_code':ifs_code,
    'bank_name':bank_name,
    'pincode': pincode,

  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
Future<void> updateFirebaseProfileFillStatus(String uid, bool formStatus) async {
  FirebaseFirestore.instance.collection('Users')
      .doc(uid)
      .update({
    'spFormFill': formStatus,
  });
}
Future setUserProfile(String uid,bool farmer,bool serviceProvider,bool labour,bool spFormFill) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Users');
  serviceProvidersCollectionReference
      .doc(uid)
      .set({
    'farmer': farmer, // John Doe
    'labour': serviceProvider, // Stokes and Sons
    'serviceProvider': labour,
    'spFormFill': spFormFill,

  });
}






Future sp_addservice(String uid,String service_name,String category,
    String price_per_unit,String description ,List<String> imageurl) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
  return serviceProvidersCollectionReference
      .add({
    'serv_prov_id': uid,
    'service_name': service_name,
    'category': category,
    'price_per_unit':price_per_unit,
    //'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,


  })
      .then((value) {
        print("Service Added");
        return value.id;
      })
      .catchError((error) => print("Failed to add Service: $error"));
}
Future updateImage(List<String> imageurlList, String docid) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'imageUrl':imageurlList
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Image added"))
      .catchError((error) => print("Failed to add image: $error"));
}

Future add_to_service_booking(String uid,String service_id,String category,
    String price_per_unit,String no_of_service,String description ,List<String> imageurl) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('services');
  return serviceProvidersCollectionReference
      .add({
    'serv_prov_id': uid,
    'service_id': service_id,
    'category': category,
    'price_per_unit':price_per_unit,
    'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,


  })
      .then((value) {
    print("Service Added");
    return value.id;
  })
      .catchError((error) => print("Failed to add Service: $error"));
}

Future UpdateImageFarmAdd(List<String> imageurlList,String uid, String docid,double latitude,double longitude) async {
  await FirebaseFirestore.instance.collection('farmUser')
      .doc(uid).collection("farms")
      .doc(docid)
      .update({
    'imageUrl':imageurlList,
    'location':GeoPoint(latitude,longitude),
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Image added"))
      .catchError((error) => print("Failed to add image: $error"));
}

Future sp_updateService(String docid,String service_name,String category,
    String price_per_unit,String description ,List<String> imageurl) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'name': service_name,
    'category': category,
    'price_per_unit':price_per_unit,
    //'no_of_service':no_of_service,
    'description':description,
    'imageUrl':imageurl,
    //'imageUrl':FieldValue.arrayUnion(["imageurlList"]),
  })
      .then((value) => print("Updated"))
      .catchError((error) => print("Failed to Updated: $error"));
}


Future addBooking(Service service, Users user,String farmType,String farmName,Timestamp startTime,Timestamp endTime) async {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference serviceProvidersCollectionReference = firebaseFirestore.collection('Bookings');
  return serviceProvidersCollectionReference
      .add({
    'farmType':farmType,
    'farmName':farmName,
    'price':service.price,
    'uid':user.uid,
    'spid':service.serv_prov_id,
    'spName':service.spName,
    'serviceName':service.name,
    'startTime': startTime,
    'endTime': endTime,
    'createdOn':FieldValue.serverTimestamp(),



  })
      .then((value) {
    print("start&end time Added");
  })
      .catchError((error) => print("Failed to add start&end time: $error"));
}


Future addReview(String docid,String uid,String image,String name, String rating,String comment) async {
  await FirebaseFirestore.instance.collection('services')
      .doc(docid).collection("Review")
      .doc(uid)
      .set({
    'image': image, // John Doe
    'name': name, // Stokes and Sons
    'rating': rating,
    'comment': comment,
    'createdOn':FieldValue.serverTimestamp()
  });

  await FirebaseFirestore.instance.collection('services')
      .doc(docid)
      .update({
    'reviewList': FieldValue.arrayUnion([uid]), // John Doe

  });
}

/// Check If Document Exists








