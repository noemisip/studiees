class User {
 int id;
 String username;
 String name;
 String email;
 String password;
 int birthdate;
 String university;
 bool role;


 User(this.id, this.username, this.name, this.email, this.password,
     this.birthdate,
     this.university, this.role);

 User.fromJson(Map<dynamic, dynamic> json)
     : id = json['id'] as int,
      username = json['username'] as String,
      name = json['name'] as String,
      email = json['email'] as String,
      password = json['password'] as String,
      birthdate = json['birthdate'] as int,
      university = json['universirty'] as String,
      role = json['role'] as bool;


 Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
  'id': id,
  'username': username,
  'name': name,
  'email': email,
  'password': password,
  'birthdate': birthdate,
  'univeristy': university,
  'role': role,
 };

}