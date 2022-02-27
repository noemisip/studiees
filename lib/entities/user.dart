
class UserModel {
 String? uid;
 String? username;
 String? name;
 String? email;
 String? password;
 int? birthdate;
 String? university;
 bool? role;

 UserModel({this.uid,this.username,this.name, this.email,this.password,this.birthdate, this.university,this.role});

 // receiving data from server
 factory UserModel.fromMap(map) {
  return UserModel(
   uid: map['uid'],
   username: map['username'],
   name: map['name'],
   email: map['email'],
   password: map['password'],
   birthdate: map['birthdate'],
   university: map['university'],
   role: map['role'],
  );
 }

 // sending data to our server
 Map<String, dynamic> toMap() {
  return {
   'uid': uid,
   'username': username,
   'name': name,
   'email': email,
   'password': password,
   'birthdate': birthdate,
   'university': university,
   'role': role,
  };
 }
}