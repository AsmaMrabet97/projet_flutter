class CategorieModel {
  String? id;
  String? title;

  CategorieModel({this.id, this.title});

  //receiving data from server
  factory CategorieModel.fromMap(map) {
    return CategorieModel(id: map['id'], title: map['title']);
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
