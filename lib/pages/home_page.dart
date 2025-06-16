import 'package:flutter/material.dart';
import '../pages/cart_page.dart';
import '../components/bottom_nav_bar.dart';
import '../pages/shop_page.dart';
import '../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //--------------------- Navigate BottomBar ---------

  var _selectedIndex = 0;
  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  //---------------- Pages ----------
  final List<Widget> _pages = [
    ShopPage(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(backgroundColor: bgColor, scrolledUnderElevation: 0),
      drawer: Drawer(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 150,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white))
                  ),
                  child: Image.asset('assets/images/mini-coffee-shop-logo.png', width: 100,),
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        title: Text("Home", style: TextStyle(color: Colors.grey[700]),),
                        leading: Icon(Icons.home, color: Colors.grey[700],),
                      ),

                      ListTile(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        title: Text("About" , style: TextStyle(color: Colors.grey[700])),
                        leading: Icon(Icons.info, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),


              ],
            ),

            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListTile(
                    onTap: () {
                      // Logout function here
                      Navigator.pop(context);
                    },
                    title: Text("Logout", style: TextStyle(color: Colors.grey[700])),
                    leading: Icon(Icons.logout, color: Colors.grey[700]),
                  ),
                )
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
