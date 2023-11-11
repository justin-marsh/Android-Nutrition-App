import 'package:flutter/material.dart';
import 'recipeManagement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Recipe> recipes = [
    Recipe(
      name: "Recipe 1",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img1.png",
    ),
    Recipe(
      name: "Recipe 2",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img2.png",
    ),
    Recipe(
      name: "Recipe 3",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img3.png",
    ),
    Recipe(
      name: "Recipe 4",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img4.png",
    ),
    Recipe(
      name: "Recipe 5",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img5.png",
    ),
    Recipe(
      name: "Recipe 6",
      difficulty: 2,
      calories: 400,
      ingredients: ["Ingredient 1", "Ingredient 2"],
      diet: ["Vegetarian", "Vegan"],
      imagepath: "img6.png",
    ),
    Recipe(
      name: "Recipe 7",
      difficulty: 1,
      calories: 300,
      ingredients: ["Ingredient 3", "Ingredient 4"],
      diet: ["Gluten-Free", "Low-Carb"],
      imagepath: "img7.png",
    ),
    Recipe(
      name: "Recipe 8",
      difficulty: 1,
      calories: 300,
      ingredients: ["Ingredient 3", "Ingredient 4"],
      diet: ["Gluten-Free", "Low-Carb"],
      imagepath: "img8.png",
    ),
    Recipe(
      name: "Recipe 9",
      difficulty: 1,
      calories: 300,
      ingredients: ["Ingredient 3", "Ingredient 4"],
      diet: ["Gluten-Free", "Low-Carb"],
      imagepath: "img9.png",
    ),
    Recipe(
      name: "Recipe 10",
      difficulty: 1,
      calories: 300,
      ingredients: ["Ingredient 3", "Ingredient 4"],
      diet: ["Gluten-Free", "Low-Carb"],
      imagepath: "img10.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyLayout(recipes: recipes),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange.shade800,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavBarIcon(icon: Icons.home, onPressed: () => print("HOME")),
                BottomNavBarIcon(icon: Icons.search, onPressed: () => print("SEARCH")),
                BottomNavBarIcon(icon: Icons.add, onPressed: () => print("ADD")),
                BottomNavBarIcon(icon: Icons.favorite, onPressed: () => print("FAVOURITE")),
                BottomNavBarIcon(icon: Icons.person, onPressed: () => print("PERSON")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeTile extends StatelessWidget {
  final Recipe recipe;

  const RecipeTile({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Added padding for centering
      padding: const EdgeInsets.all(8.0), 
      child: Column(
        children: [
          // Recipe Image placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.purple.shade400,
            ),
          ),
          SizedBox(height: 8.0),

          // Text displaying recipe information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recipe: ${recipe.name}'),
              // More Info for recipes if we want to display them
              Text('Difficulty: ${recipe.difficulty}'),
              Text('Calories: ${recipe.calories}'),
              SizedBox(height: 8.0),

              // Orange Button with White Text "View"
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade800,
                  onPrimary: Colors.white,
                ),
                child: Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class MyLayout extends StatelessWidget {

  final List<Recipe> recipes;
  MyLayout({required this.recipes});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title and header section
        Container(
          color: Colors.orange.shade800,
          height: 150,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Recipes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Find healthy recipes', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Repeatable section for recipes to be displayed
        Expanded(
          child: ListView.builder(
            itemCount: (recipes.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              int firstIndex = index * 2;
              int secondIndex = index * 2 + 1;

              // Check if either index exceeds the itemCount
              if (firstIndex >= recipes.length || secondIndex >= recipes.length) {
                // Stop the loop early
                return SizedBox.shrink();
              }

              return Column(
                children: [
                  Row(
                    children: [
                      RecipeTile(recipe: recipes[firstIndex]),
                      SizedBox(width: 80.0), // Adjust spacing
                      RecipeTile(recipe: recipes[secondIndex]),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Divider( // Thin grey lines
                    color: Colors.grey,
                    height: 1.0,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}




class BottomNavBarIcon extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const BottomNavBarIcon({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
}

