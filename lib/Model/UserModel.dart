class UserModel{

  String _id="";

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String _Name="";
  String _Age="";

  String get Name => _Name;
  set Name(String newName){
    _Name=newName;
  }

  String get Age => _Age;
  set Age(String newAge){
    _Age=newAge;
  }

  Map<String,dynamic> toMap(){
    return {
      'id':_id,
      'Name':_Name,
      'Age':_Age
    };
  }
}