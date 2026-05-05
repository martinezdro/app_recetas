
import 'package:flutter/material.dart';
import 'package:app_recetas/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_recetas/widgets/recipe_item.dart';
import 'package:app_recetas/screens/add_recipe_screen.dart';



class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();

}



class _RecipeListScreenState extends State<RecipeListScreen> {
  String _searchQuery = '';
  bool _showFavoritesOnly = false;
  

  @override
  Widget build(BuildContext context){
    final recipeProvider = Provider.of<RecipeProvider>(context);
    //final recipes = recipeProvider.recipes;
    
    /*
    final recipes = recipeProvider.recipes.where((recipe) {
      final lowerQuery = _searchQuery.toLowerCase();
      return recipe.title.toLowerCase().contains(lowerQuery) ||
      recipe.ingredients.any((ingrendint) => ingrendint.toLowerCase().contains(lowerQuery));
    }).toList();
    */


    final recipes = _showFavoritesOnly
        ? recipeProvider.favoriteRecipes
        : recipeProvider.recipes.where((recipe) {
            final loweQuery = _searchQuery.toLowerCase();
            return recipe.title.toLowerCase().contains(loweQuery) ||
                recipe.ingredients.any((ingredient) =>
                    ingredient.toLowerCase().contains(loweQuery));
          }).toList();



    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas de Cocina 🍲'),
      
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_border),
          )
        ],

      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar Recetas..',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ), // inputdecoration

              onChanged: (query){
                setState(() {
                  _searchQuery = query;
                });

              },

            ), // texfield

          ), // padding

          Expanded(
            child: recipes.isEmpty
            ? const Center(
              child: Text('No se encontraron recetas..'))
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context,index){
                  return RecipeItem(recipe:recipes[index]);
                },
              )              
          ),

        ], // column

      ),  
        
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddRecipeScreen()
          ));

        },

        child: const Icon(Icons.add),

      ), // floating
    
      
    );
  }

}
