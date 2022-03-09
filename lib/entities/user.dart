
class UserModel {
 String? uid;
 String? username;
 String? name;
 String? email;
 int? birthdate;
 String? university;
 bool? role;
 String? currentSemester;

 UserModel({this.uid,this.username,this.name, this.email,this.birthdate, this.university,this.role, this.currentSemester});

 // receiving data from server
 factory UserModel.fromMap(map) {
  return UserModel(
   uid: map['uid'],
   username: map['username'],
   name: map['name'],
   email: map['email'],
   birthdate: map['birthdate'],
   university: map['university'],
   role: map['role'],
   currentSemester: map['current_semester']
  );
 }

 // sending data to our server
 Map<String, dynamic> toMap() {
  return {
   'uid': uid,
   'username': username,
   'name': name,
   'email': email,
   'birthdate': birthdate,
   'university': university,
   'role': role,
   'current_semester': currentSemester,
  };
 }
}