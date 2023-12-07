import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



Future<void> createTable() async {
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

  await db.insert('recipes', {
    'id': await getRecipeCount(),
    'name': recipe.name,
    'description': recipe.description,
    'calories': recipe.calories,
    'difficulty': recipe.difficulty,
    'ingredients': recipe.ingredients.join(', '),
    'diet': recipe.diet.join(', '),
  });

  print("Database opened, and data inserted.");
}
