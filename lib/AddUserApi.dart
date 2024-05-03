import 'package:flutter/material.dart';
import 'package:untitled/Model/UserModel.dart';
import 'package:untitled/api/ApiCode.dart';

class AddUserApi extends StatefulWidget{
  Map<String,Object?>? map;
  AddUserApi(map){
    this.map = map;
  }

  @override
  State<AddUserApi> createState() => _AddUserApiState();
}

class _AddUserApiState extends State<AddUserApi> {
  final _formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageContoroller=TextEditingController();

  void initState(){
    nameController.text=widget.map==null?'':widget.map!["Name"].toString();
    ageContoroller.text=widget.map==null?'':widget.map!["Age"].toString();
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       body: Form(
         key: _formkey,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
               TextFormField(
                 decoration: InputDecoration(hintText: "Enter Name"),
                 controller: nameController,
                 validator: (value){
                   if(value!.isEmpty){
                     return 'enter name';
                   }
                 },
               ),
               TextFormField(
                 decoration: InputDecoration(hintText: "Enter Age"),
                 controller: ageContoroller,
                 validator: (value){
                   if(value!.isEmpty){
                     return 'enter name';
                   }
                 },
               ),
               SizedBox(height: 10,),
               Center(
                 child: Container(
                   child: ElevatedButton(
                     onPressed: () async {
                       if(widget.map==null){
                         insertUser().then((value) => Navigator.of(context).pop(true));
                       }
                       else{
                         editUser(widget.map!['id'].toString()).then((value) => Navigator.of(context).pop(true));
                       }
                     },
                     child: Text("Submit"),
                   ),
                 ),
               )
             ],
           ),
         ),
       )
     ),
   );
  }

  Future<void> insertUser() async {
    UserModel user= UserModel();
    user.Name=nameController.text;
    user.Age=ageContoroller.text;
    await ApiCode().insertUser(user.toMap());

  }

  Future<void> editUser(String id) async {
    UserModel user= UserModel();
    user.Name=nameController.text;
    user.Age=ageContoroller.text;
    await ApiCode().updateUser(user.toMap(),id);
    // print(id);
  }
}