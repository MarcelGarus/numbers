import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details.dart';
import 'favorites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Favorites(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Numbers"),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'numbers', icon: Icon(Icons.list)),
                  Tab(text: 'favorites', icon: Icon(Icons.favorite_border)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListOfNumbers(),
                ListOfFavorites(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfNumbers extends StatelessWidget {
  const ListOfNumbers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Hallo $index!"),
          onTap: () {
            print("Item $index clicked.");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return NumberDetailsPage(index);
              },
            ));
          },
        );
      },
    );
  }
}

class ListOfFavorites extends StatelessWidget {
  const ListOfFavorites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context);
    return ListView(
      children: [
        for (final fact in favorites.facts) ListTile(title: Text(fact)),
      ],
    );
  }
}
