class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? lastname;


  UserModel({this.uid, this.email, this.firstname, this.lastname});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstName'],
      lastname: map['lastName'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'uid' : uid,
      'email' : email,
      'firstName' : firstname,
      'lastName' : lastname
    };
  }


}
