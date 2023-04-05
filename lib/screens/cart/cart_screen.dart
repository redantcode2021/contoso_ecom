import 'package:contoso_ecom/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cart',
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.cart.freeDeliveryString,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(),
                        elevation: 0,
                      ),
                      child: Text(
                        "Add More Items",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 375,
                  child: ListView.builder(
                    itemCount: state.cart
                        .productQuantity(state.cart.products)
                        .keys
                        .length,
                    itemBuilder: (context, index) {
                      return CartProductCard(
                        product: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .elementAt(index),
                        quantity: state.cart
                            .productQuantity(state.cart.products)
                            .values
                            .elementAt(index),
                      );
                    },
                  ),
                ),
                const OrderSummary(),
              ],
            ),
          );
        }
        return const Center(
          child: Text('Something went wrong!'),
        );
      }),
    );
  }
}
