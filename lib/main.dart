import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_recetas/screens/recipe_list_screen.dart';
import 'package:app_recetas/providers/recipe_provider.dart';
import 'package:app_recetas/themes/theme.dart';



void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RecipeProvider())
    ],

    child: MyApp(),
  )

);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Recetas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: RecipeListScreen()
    );
  }
}

