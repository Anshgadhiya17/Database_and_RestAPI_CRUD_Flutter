import 'package:flutter/material.dart';
import 'package:untitled/database/My_Database.dart';

class addUser extends StatefulWidget {
  Map<String,Object?>? map;
  addUser(map){
    this.map = map;
  }
  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {
  final _formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  @override

  void initState(){
    nameController.text=widget.map==null?'':widget.map!["UserName"].toString();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Enter User Name"),
                    controller: nameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter name';
                      }
                    },
                  ),
                ),
                Center(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        if(widget.map==null){
                          insertUser().then((value) => Navigator.of(context).pop(true));
                        }
                        else{
                          editUser(int.parse(widget.map!['UserId'].toString())).then((value) => Navigator.of(context).pop(true));
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
  Future<int> insertUser() async {
    Map<String, Object?> map = Map<String, dynamic>();
    map["UserName"]=nameController.text;
    var res = await MyDatabase().insertUser(map);
    return res;
  }

  Future<int> editUser(int id) async {
    Map<String, Object?> map = Map<String, dynamic>();
    map["UserName"]=nameController.text;
    var res = await MyDatabase().UpdateUser(map, id);
    return res;
  }
}
