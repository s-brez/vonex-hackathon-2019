import 'package:flutter/cupertino.dart';

import 'offers_tab.dart';
import 'product_list_tab.dart';
import 'search_tab.dart';

import 'wishlist_tab.dart';

// class CupertinoStoreApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       home: CupertinoStoreHomePage(),
//     );
//   }
// }

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark),    //shopping_cart),
            title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections),    //shopping_cart),
            title: Text('Offers'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SearchTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: WishListTab(),     //ShoppingCartTab(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: OffersTab(),     //ShoppingCartTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
