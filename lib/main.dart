import 'package:contoso_ecom/app_bloc_observer.dart';
import 'package:contoso_ecom/blocs/blocs.dart';
import 'package:contoso_ecom/config/app_router.dart';
import 'package:contoso_ecom/config/theme.dart';
import 'package:contoso_ecom/repositories/category/category_repository.dart';
import 'package:contoso_ecom/repositories/checkout/checkout_repository.dart';
import 'package:contoso_ecom/repositories/product/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WishlistBloc()..add(StartWishlist()),
        ),
        BlocProvider(
          create: (_) => CartBloc()..add(LoadCart()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(
              LoadProducts(),
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contoso E-comm',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: OrderConfirmation.routeName,
        home: const HomeScreen(),
      ),
    );
  }
}
