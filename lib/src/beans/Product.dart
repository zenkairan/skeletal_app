class Product{
  String id;
  String title;
  String description;
  String url;

  Product(String title, String description, String url){
    this.title = title;
    this.description = description;
    this.url = url;
  }

  Product.fromJson(Map<String, dynamic> json):
  id = json['_id'],
  title = json['title'],
  description = json['description'],
  url = json['url'];

  Map<String, dynamic> toJson() =>{
    'title': title,
    'description': description,
    'url': url
  };

  @override
  String toString(){
    return 'id: ' + this.id + ' title: ' + this.title;
  }
}