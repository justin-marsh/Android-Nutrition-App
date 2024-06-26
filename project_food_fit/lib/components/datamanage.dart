import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';


Future<void> initializeDatabase() async {
  // Check if the database file exists
  bool dbExists = await databaseExists('projectdatabase.db');
  print("dbExists: $dbExists");



  if (!dbExists) {
    print("db does not exist");
    // If the database does not exist, create it
    final db = await openDatabase('projectdatabase.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE recipes ('
        'id INTEGER PRIMARY KEY,'
        'name TEXT,'
        'description TEXT,'
        'calories INTEGER,'
        'difficulty INTEGER,'
        'ingredients TEXT,'
        'diet TEXT'
        ')',
      );
    });
    print("Database created.");
  } else {
    print("Database already exists: $dbExists");
    // Check if the 'recipes' table exists
    final db = await openDatabase('projectdatabase.db');
    List<Map<String, dynamic>> tables = await db.query('sqlite_master');
    print("tables: $tables");
    bool recipesTableExists = tables.any((table) => table['name'] == 'recipes');

    print("recipesTableExists: $recipesTableExists");
    if (!recipesTableExists) {
      await db.execute(
        'CREATE TABLE recipes ('
        'id INTEGER PRIMARY KEY,'
        'name TEXT,'
        'description TEXT,'
        'calories INTEGER,'
        'difficulty INTEGER,'
        'ingredients TEXT,'
        'diet TEXT'
        ')',
      );
    }
    else{
      print("table already exists");
    }

  }

  print("at this point there should be no issues on the database or tables existence");
  print("");




    // Check if the 'recipes' table is empty
  int? rowCount = await getRecipeCount();
  
  if (rowCount == 0) {
    print("No rows of data found. Adding template recipes.");

    // Insert 10 template recipes
    for (int i = 0; i < 10; i++) {
      Recipe templateRecipe = Recipe(
        name: 'Template Recipe $i',
        description: 'This is a template recipe.',
        calories: 200,
        difficulty: 2,
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        diet: ['Vegetarian'],
      );
      await addRecipe(templateRecipe);
    }

    print("Template recipes inserted.");
  } else {
    print("Rows of data exist.");
  }
}


Future<bool> checkDatabase() async {
  try {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'projectdatabase.db');
    await openDatabase(path);
    return true; // Database exists
  } catch (_) {
    return false; // Database does not exist
  }
}
void checkDatabasePath() async {
  final db = await openDatabase('projectdatabase.db');

  var docDir = await getDatabasesPath();
  String path = join(docDir, 'projectdatabase');
  print("Path:");
  print(path);
}

void insertData(row) async {
  final db = await openDatabase('projectdatabase.db');
  await db.insert('recipes', row);
}

Future<int?> getRecipeCount() async {
  final db = await openDatabase('projectdatabase.db');

  final result = await db.rawQuery('SELECT COUNT(*) FROM recipes');
  return Sqflite.firstIntValue(result);
}

/// Fetches resources from the 'recipes' table based on specified conditions.
///
/// This function performs a SELECT query on the 'recipes' table in the database.
/// It allows you to retrieve specific columns for rows that satisfy a given condition.
///
/// Parameters:
///   - [columns]: A comma-separated string of column names to retrieve.
///   - [column]: The column name for the condition.
///   - [operation]: The operation to apply in the condition (e.g., '=', '>', '<').
///   - [value]: The value to compare against in the condition.
///
/// Returns:
///   A list of maps representing the selected rows from the 'recipes' table.
///   Each map contains column names as keys and corresponding values.
///
/// Example:
/// ```dart
/// var result = await fetchResource1('name, description', 'difficulty', '=', 3);
/// print(result);
/// ```
Future<List<Map<String, dynamic>>> fetchResource1(columns, column, operation, value) async {
    final db = await openDatabase('projectdatabase.db');

    final result = await db.rawQuery("SELECT "+ columns +" FROM recipes WHERE "+ column +" "+ operation +" ?", [(value).toString()]);
    return result;
}


class Recipe {
  String name;
  String description;
  int calories;
  int difficulty;
  List<String> ingredients;
  List<String> diet;

  Recipe({
    required this.name,
    required this.description,
    required this.calories,
    required this.difficulty,
    required this.ingredients,
    required this.diet
  });
  
  static Recipe empty() {
    return Recipe(
      name: '',
      description: '',
      difficulty: 0,
      calories: 0,
      ingredients: [],
      diet: [],
    );
  }
  
}
Future<void> addRecipe(Recipe recipe) async {
  final db = await openDatabase('projectdatabase.db');
  Random random = Random();

  // Generate a random integer between 1 and 5 (inclusive)
  int randomNumber = random.nextInt(100000) + 1;
  await db.insert('recipes', {
    'id': randomNumber,
    'name': recipe.name,
    'description': recipe.description,
    'calories': recipe.calories,
    'difficulty': recipe.difficulty,
    'ingredients': recipe.ingredients.join(', '),
    'diet': recipe.diet.join(', '),
  });

  print("Database opened, and data inserted.");
}
Future<void> addRecipes(Recipe recipe) async {
  final db = await openDatabase('projectdatabase.db');
  Random random = Random();

  // Generate a random integer between 1 and 5 (inclusive)
  int randomNumber = random.nextInt(100000) + 1;
  await db.insert('recipes', {
    'id': randomNumber,
    'name': recipe.name,
    'description': recipe.description,
    'calories': recipe.calories,
    'difficulty': recipe.difficulty,
    'ingredients': recipe.ingredients.join(', '),
    'diet': recipe.diet.join(', '),
  });

  print("Database opened, and data inserted.");
}