import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_haffeli/models/singers.dart';

class DetailsUser extends StatefulWidget {
  const DetailsUser({Key? key}) : super(key: key);

  @override
  State<DetailsUser> createState() => _DetailsUserState();
}

class _DetailsUserState extends State<DetailsUser> {
  List<SingerModel> singersList = [];
  List _singers = [];

  getdata() async {
    CollectionReference singers =
        FirebaseFirestore.instance.collection("singers");
    await singers.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          SingerModel singer = SingerModel.fromMap(element.data());
          singersList.add(singer);
        });
        print(element.data());
        // print("---------------------------------------");
      });
    });
  }
  //print(singersList.length);

  @override
  void initState() {
    getdata();
    super.initState();
  }

  onSearch(String search) {
    setState(() {
      _singers = singersList
          .where(
              (SingerModel) => SingerModel.name!.toLowerCase().contains(search))
          .toList();
    });
    // print(_singers[1].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Container(
              padding: EdgeInsets.only(top: 15),
              height: 70,
              child: TextField(
                onChanged: ((value) {
                  onSearch(value);
                  // print(value);
                }),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search,
                        color: Color.fromARGB(255, 69, 68, 68)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 69, 68, 68)),
                    hintText: "Recherche artiste"),
              ),
            ),
            expandedHeight: 150,
            floating: true,
            excludeHeaderSemantics: true,
            backgroundColor: Colors.grey[900],
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Sélectionnez 3 artistes ou plus que vous aimez"),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, i) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      doMultiSelction("${_singers[i].id}");
                    },
                    child: Container(
                      // radius: 0,
                      // backgroundImage: NetworkImage("${singersList[i].imageUrl}"),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${_singers[i].imageUrl}"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(
                            Selected.contains("${_singers[i].id}") ? 80 : 20),
                      ),
                      child: Text(
                        "${_singers[i].name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 5.5),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _singers.length,
              primary: false,
              shrinkWrap: true,
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, i) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      doMultiSelction("${singersList[i].id}");
                    },
                    child: Container(
                      // radius: 0,
                      // backgroundImage: NetworkImage("${singersList[i].imageUrl}"),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${singersList[i].imageUrl}"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(
                            Selected.contains("${singersList[i].id}")
                                ? 80
                                : 20),
                      ),
                      child: Text(
                        "${singersList[i].name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 5.5),
                      ),
                    ),
                  ),
                );
              },
              itemCount: singersList.length,
              primary: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: Selected.length >= 3
            ? () {
                print('ok');
              }
            : null,
        label: Text('Contine'),
        backgroundColor: Selected.length >= 3
            ? Color.fromARGB(242, 45, 129, 239)
            : Color.fromARGB(240, 147, 183, 228),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  HashSet Selected = new HashSet();
  void doMultiSelction(String id) {
    setState(() {
      if (Selected.contains(id)) {
        Selected.remove(id);

        print(Selected);
      } else {
        Selected.add(id);

        print(Selected);
      }
    });
  }
}
