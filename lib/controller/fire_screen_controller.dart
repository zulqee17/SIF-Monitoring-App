

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FireScreenController extends GetxController{
  RxInt flame1=0.obs;
  
  final _ref=FirebaseDatabase.instance.ref('device1');
  
  Stream<Map> get getStreamData{
    return _ref.onValue.map((event)=>event.snapshot.value as Map);
  }
  
  void updateValue(Map data){
    if(data.containsKey('flame1')){
      flame1.value=data['flame1'];
    }
  }
}