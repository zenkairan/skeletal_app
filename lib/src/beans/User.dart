
//talvez deva conter instancia de profile
class User{
  String id;
  String name;
  String email;
  String password;
  String facebookId;
  String picture;
  String about;
  
  User(String name, String email, String password){
    this.name = name;
    this.email = email;
    this.password = password;
  }

  User.fromJason(Map<String, dynamic> json):
    id = json['_id'],
    name = json['name'],
    email = json['email'],
    password = json['password'],
    facebookId = json['facebookId'],
    picture = json['picture'],
    about = json['about'];

  Map<String, dynamic> toJson() =>
  {
    // '_id': id, id não faz parte do request
    'name': name,
    'email': email,
    'password': password,
    'facebookId': facebookId,
    'picture': picture,
    'about': about
  };

@override
  String toString(){
    return ' name: ' + this.name + 'email: ' + this.email;
  }
}