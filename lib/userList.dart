import 'package:flutter/material.dart';
import 'package:untitled/addUser.dart';
import 'package:untitled/database/My_Database.dart';

class userList extends StatefulWidget {
  @override
  State<userList> createState() => _userListState();
}

class _userListState extends State<userList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('database demo')),
      body: Container(
        color: Colors.blue,
        child: FutureBuilder(
          future: MyDatabase().copyPasteAssetFileToRoot(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: MyDatabase().getDetails(),
                builder: (context, snapshotData) {
                  if (snapshotData.hasData) {
                    return ListView.builder(
                      itemCount: snapshotData.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Row(
                          children: [
                            Text(
                              snapshotData.data![index]['UserId'].toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                child: Text(
                              snapshotData.data![index]['UserName'].toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return addUser(snapshotData.data![index]);
                                    },
                                  )).then((value) => setState(() {}));
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  await MyDatabase()
                                      .deleteById(
                                          snapshotData.data![index]['UserId'])
                                      .then((value) => setState(() {}));
                                },
                                child: Icon(Icons.delete))
                          ],
                        ));
                      },
                    );
                  } else {
                    return Text('coping.....');
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return addUser(null);
              },
            )).then((value) => setState((){}));
          },
          child: Icon(
            Icons.add,
            size: 50,
            color: Colors.brown,
          )),
    );
  }
}
