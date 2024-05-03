import 'package:flutter/material.dart';
import 'package:untitled/AddUserApi.dart';
import 'package:untitled/api/ApiCode.dart';

class UserListApi extends StatefulWidget {
  @override
  State<UserListApi> createState() => _UserListApiState();
}

class _UserListApiState extends State<UserListApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Api demo'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddUserApi(null);
              },)).then((value) {
                setState(() {

                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ApiCode().getDetails(),
        builder: (context, snapshotData) {
          if (snapshotData.hasData) {
            return ListView.builder(
              itemCount: snapshotData.data!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshotData.data![index].Name.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            snapshotData.data![index].Age.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('Alert!'),
                              content: Text('Are you sure want to delete ?'),
                              actions: [
                                TextButton(onPressed: () {
                                  ApiCode().deleteById(
                                      snapshotData.data![index].id.toString()).then((
                                      value) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
                                }, child: Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text('No'))
                              ],
                            );
                          },);
                        }, icon: Icon(Icons.delete)),
                        IconButton(onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return AddUserApi(snapshotData.data![index]);
                              },)).then((value) {
                            setState(() {});
                          });
                        }, icon: Icon(Icons.edit)),
                      ],
                    ));
              },
            );
          }
          else if(snapshotData.hasError){
            return Center(child: Text(snapshotData.error.toString()));
          }
          else  {
            return Text('coping.....');
          }
        },
      ),
    );
  }
}