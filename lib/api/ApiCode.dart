import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/Model/UserModel.dart';


class ApiCode{

  Future<List<UserModel>> getDetails() async {
    var response = await http.get(Uri.parse('https://64a2abf9b45881cc0ae581cd.mockapi.io/product/Faculty'));
    List<UserModel> itemList=<UserModel>[];
    List<dynamic> data=jsonDecode(response.body);
    // print(data);
    for(int i=0;i<data.length;i++){
        UserModel model = UserModel();
        model.Name=data[i]['Name'];
        model.Age=data[i]['Age'].toString();
        model.id=data[i]['id'];

        itemList.add(model);

     

      
    }

    return itemList;
  }

  Future<void> deleteById(String id) async {
    var response = await http.delete(Uri.parse('https://64a2abf9b45881cc0ae581cd.mockapi.io/product/Faculty/'+id));
  }

  Future<void> insertUser(Map<String,dynamic> map) async {
    var jsonMap=jsonEncode(map);
    var response = await http.post(Uri.parse('https://64a2abf9b45881cc0ae581cd.mockapi.io/product/Faculty'),headers: {'Content-Type':'application/json'},body:jsonMap);
  }

  Future<void> updateUser(Map<String,dynamic> map,String id) async {
    var jsonMap=jsonEncode(map);
    var response = await http.put(Uri.parse('https://64a2abf9b45881cc0ae581cd.mockapi.io/product/Faculty/'+id),headers: {'Content-Type':'application/json'},body:jsonMap);
  }
}