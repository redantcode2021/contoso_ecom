import 'package:contoso_ecom/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WishlistScreen(),
    );
  }

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Wishlist',
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
        if (state is WishlistLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        if (state is WishlistLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.4,
            ),
            itemCount: state.wishlist.products.length,
            itemBuilder: (context, index) {
              return Center(
                child: ProductCard(
                  product: state.wishlist.products[index],
                  widthFactor: 1.1,
                  leftPosition: 100,
                  isWishlist: true,
                ),
              );
            },
          );
        }
        return const Text('Something went wrong!');
      }),
    );
  }
}
