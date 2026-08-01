import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_cart_app/cubit/address_cubit.dart';
import 'package:shopping_cart_app/cubit/cart_cubit.dart';
import 'package:shopping_cart_app/cubit/payment_cubit.dart';
import 'package:shopping_cart_app/cubit/product_cubit.dart';
import 'package:shopping_cart_app/cubit/wishlist_cubit.dart';
import 'package:shopping_cart_app/screens/main_screen.dart';
import 'package:shopping_cart_app/services/api_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cartBox');
  await Hive.openBox('wishlistBox');
  await Hive.openBox('addressBox');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ProductCubit(ApiService())..fetchProducts(),
      ),
      BlocProvider(
        create: (_) => CartCubit(),
      ),
      BlocProvider(
        create: (_) => PaymentCubit(),
      ),
      BlocProvider(
        create: (_) => WishlistCubit(),
      ),
      BlocProvider(
        create: (_) => AddressCubit(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xffF8f9fA),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ))),
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ))),
      home: const MainScreen(),
    );
  }
}
