

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class IndustrialGasScreenController extends GetxController{

  final _ref=FirebaseDatabase.instance.ref('device2');
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  var indGasValue=0.0.obs;

  Stream<Map> get getStreamData{
    return _ref.onValue.map((event)=>event.snapshot.value as Map);
  }

  void updateValue(Map data)async{
    try{
      if(data.containsKey('smoke2')){
        indGasValue.value=double.parse(data['smoke2'].toString());

        await _firebaseFirestore.collection('industrial_gas_data').add({
          'industrialGasValue':indGasValue.value,
          'timestamp':DateTime.now()
        });
      }
    }catch(e){
      throw 'error : $e';
    }
  }

  Stream<List<Map<String, dynamic>>> getStoredData() {
    final now = DateTime.now();
    final last4HourData = now.subtract(const Duration(hours: 4));

    return _firebaseFirestore
        .collection('industrial_gas_data')
        .where('timestamp', isGreaterThanOrEqualTo: last4HourData)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .debounceTime(const Duration(seconds: 2)) // Add a debounce delay of 1 second
        .map((snapshot) {
      final data = snapshot.docs.map((doc) => {
        'industrialGasValue': doc['industrialGasValue'],
        'timestamp': doc['timestamp']
      }).toList();
      if (kDebugMode) {
        print('Data fetched successfully');
      }
      return data;
    });
  }
}