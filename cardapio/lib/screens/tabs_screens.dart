import 'package:cardapio/components/main_drawer.dart';
import 'package:cardapio/models/meal.dart';
import 'package:cardapio/screens/categories_screnn.dart';
import 'package:cardapio/screens/favorite_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({Key key, this.favoriteMeals}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        "title": "Lista de Categorias",
        "screen": CategoriesScreen(),
      },
      {
        "title": "Favoritos",
        "screen": FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
      }
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]["title"]),
        centerTitle: true,
      ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categorias"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favoritos"),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}

// DefaultTabController(
//       length: 2,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Vamos Cozinhar"),
//           centerTitle: true,
//           bottom: TabBar(tabs: [
//             Tab(
//               icon: Icon(Icons.category),
//               text: 'Categorias',
//             ),
//             Tab(
//               icon: Icon(Icons.favorite),
//               text: 'Favoritos',
//             ),
//           ]),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             CategoriesScreen(),
//             FavoriteScreen(),
//           ],
//         ),
//       ),
//     );
