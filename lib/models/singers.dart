class SingerModel {
  String? id;
  String? name;
  String? category;
  String? imageUrl;

  SingerModel({this.id, this.name, this.category, this.imageUrl});

  //receiving data from server
  factory SingerModel.fromMap(map) {
    return SingerModel(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        imageUrl: map['imageUrl']);
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'category': category, 'imageUrl': imageUrl};
  }
}
