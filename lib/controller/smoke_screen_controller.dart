

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';


class SmokeScreenController extends GetxController{
  var smoke1=0.0.obs;

  final _ref=FirebaseDatabase.instance.ref('device1');
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  Stream<Map> get getStreamData{
    return _ref.onValue.map((event)=>event.snapshot.value as Map);
  }

  void updateValue(Map data)async{
    try{
      if(data.containsKey('smoke1')){
        smoke1.value=double.parse(data['smoke1'].toString());

        await _firebaseFirestore.collection('smoke_data').add({
          'smokeValue':smoke1.value,
          'timestamp':DateTime.now()
        });
        if (kDebugMode) {
          print('Data stored successfully: $smoke1');
        }
      }
    }catch(e){
      throw 'error while fetching data :$e';
    }
  }

  Stream<List<Map<String, dynamic>>> getStoredData() {
    final now = DateTime.now();
    final last4HourData = now.subtract(const Duration(hours: 4));

    return _firebaseFirestore
        .collection('smoke_data')
        .where('timestamp', isGreaterThanOrEqualTo: last4HourData)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .debounceTime(const Duration(seconds: 2)) // Add a debounce delay of 1 second
        .map((snapshot) {
      final data = snapshot.docs.map((doc) => {
        'smokeValue': doc['smokeValue'],
        'timestamp': doc['timestamp']
      }).toList();
      if (kDebugMode) {
        print('Data fetched successfully');
      }
      return data;
    });
  }

}

