import 'dart:ffi';

import 'package:hive/hive.dart';

class DbHelper{
  late Box box;

  DbHelper(){
    openBox();
  }

  openBox(){
    box =Hive.box('reward');
  }
  Future addData(String category, String id) async{
    var value = {'category' : category, 'id' : id};
    box.add(value);
  }

  Future<Map> fetch(){
    if(box.values.isEmpty){
      return Future.value({});
    }else{
      return Future.value(box.toMap());
    }
  }

}