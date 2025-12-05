class AccountDetailsModel{
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? insertedAt;
  String? updatedAt;
  AccountDetailsModel({this.id,this.name,this.email,
   this.insertedAt,this.updatedAt,this.phone,this.address});

  AccountDetailsModel.fromJson({required Map<String,dynamic> json}){
     id=json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    address = json["address"];
    insertedAt = json["inserted_at"];
    updatedAt = json["updated_at"];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};
    data["name"] = name;
    data["phone"] = phone;
    data["address"] = address;
    return data;

  }
}