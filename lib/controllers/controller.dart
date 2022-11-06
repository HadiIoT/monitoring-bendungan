import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class getdataController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference dataSensor = firestore.collection("Sensor");

    return dataSensor.snapshots();
  }
}
