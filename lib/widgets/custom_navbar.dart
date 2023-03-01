import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;
  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavbar(context);
      case '/catalog':
        return _buildNavbar(context);
      case '/wishlist':
        return _buildNavbar(context);
      case '/order-confirmation':
        return _buildNavbar(context);
      case '/product':
        return _buildAddToCartNavBar(context, product);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context);
      default:
        return _buildNavbar(context);
    }
  }

  List<Widget> _buildNavbar(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        icon: Icon(Icons.home),
        color: Colors.white,
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        icon: Icon(Icons.shopping_cart),
        color: Colors.white,
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
        icon: Icon(Icons.person),
        color: Colors.white,
      ),
    ];
  }

  List<Widget>? _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.share, color: Colors.white),
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              context.read<WishlistBloc>().add(AddProductToWishlist(product));

              final snackBar =
                  SnackBar(content: Text('Added to your Wishlist!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: const Icon(Icons.favorite, color: Colors.white),
          );
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              context.read<CartBloc>().add(
                    AddProductToCart(product),
                  );
              Navigator.pushNamed(context, '/cart');
            },
            child: Text(
              'ADD TO CART',
              style: Theme.of(context).textTheme.headline3,
            ),
          );
        },
      )
    ];
  }

  List<Widget>? _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    ];
  }

  List<Widget>? _buildOrderNowNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CheckoutLoaded) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                context.read<CheckoutBloc>().add(
                      ConfirmCheckout(checkout: state.checkout),
                    );

                Navigator.pushNamed(context, '/order-confirmation');
              },
              child: Text(
                'ORDER NOW',
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    ];
  }
}
