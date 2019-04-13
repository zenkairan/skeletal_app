
//talvez deva conter instancia de profile
class User{
  int id;
  String name;
  String email;
  String password;
  String facebookId;
  String picture;
  
  User(String name, String email, String password){
    this.name = name;
    this.email = email;
    this.password = password;
  }

  User.fromJason(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'],
    email = json['email'],
    password = json['password'],
    facebookId = json['facebookId'],
    picture = json['picture'];

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'facebookId': facebookId
  };
}