import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/categories.dart';

class DetailCategory extends StatefulWidget {
  const DetailCategory({Key? key}) : super(key: key);

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  List<CategorieModel> categoriesList = [];
  List<CategorieModel> Selected = [];
  getdata() async {
    CollectionReference singers =
        FirebaseFirestore.instance.collection("categories");
    await singers.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          CategorieModel categorie = CategorieModel.fromMap(element.data());
          categoriesList.add(categorie);
        });
        print(element.data());
      });
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  void doMultiSelction(CategorieModel categorieModel) {
    setState(() {
      if (Selected.contains(categorieModel))
        Selected.remove(categorieModel);
      else
        Selected.add(categorieModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Sélectionnez les categories que vous aimez"),
              centerTitle: true,
            ),
            expandedHeight: 150,
            floating: true,
            excludeHeaderSemantics: true,
            backgroundColor: Colors.grey[900],
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, i) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      doMultiSelction(categoriesList[i]);
                    },
                    child: Container(
                      // radius: 0,
                      // backgroundImage: NetworkImage("${singersList[i].imageUrl}"),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/music.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(
                            Selected.contains(categoriesList[i]) ? 80 : 20),
                        border: Border.all(
                          width: 4,
                          color: Selected.contains(categoriesList[i])
                              ? Color.fromARGB(242, 45, 129, 239)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        "${categoriesList[i].title}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            height: 3.5),
                      ),
                    ),
                  ),
                );
              },
              itemCount: categoriesList.length,
              primary: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: Selected.length >= 1
            ? () {
                print('ok');
              }
            : null,
        label: Text('Contine'),
        backgroundColor: Selected.length >= 1
            ? Color.fromARGB(242, 45, 129, 239)
            : Color.fromARGB(240, 147, 183, 228),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
