import 'package:firebase_ornek/screens/alphabets.dart';
import 'package:firebase_ornek/screens/colors.dart';
import 'package:firebase_ornek/screens/counting.dart';
import 'package:firebase_ornek/widgets/category_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _categories = [
    CategoryCard(
      title: 'Colors',
      primaryColor: Colors.blue,
      secondaryColor: Colors.blue,
      screen: ColorsScreen(
        title: 'Colors',
        primaryColor: Colors.blue,
        secondaryColor: Colors.blue,
      ),
    ),
    CategoryCard(
      title: '123',
      primaryColor: Colors.blue,
      secondaryColor: Colors.blue,
      screen: CountingScreen(
        title: '123',
        primaryColor: Colors.blue,
        secondaryColor: Colors.blue,
      ),
    ),
    CategoryCard(
      title: 'ABC',
      primaryColor: Colors.blue,
      secondaryColor: Colors.blue,
      screen: AlphabetsScreen(
        title: 'ABC',
        primaryColor: Colors.blue,
        secondaryColor: Colors.blue,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          image: DecorationImage(
            image: AssetImage('assets/images/bg-bottom.png'),
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 188.0,
              backgroundColor: Colors.grey[50],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/bg-top.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(_categories),
            ),
          ],
        ),
      ),
    );
  }
}
