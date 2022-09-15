class Course{
  int? _id;
  String? _name;
  String? _content;
  int? _price;


  Course.init();

  Course(dynamic obj){
    _id = obj['id'];
    _name = obj['name'];
    _content = obj['content'];
    _price = obj['price'];
  }



  Map<String, dynamic> toMap() => {'id' : _id,'name' : _name,'content' : _content, 'price' : _price};

  int? get id => _id;
  String? get name => _name;
  String? get content => _content;
  int? get price => _price;
}