import 'package:flutter/material.dart';
import 'package:project_food_fit/components/datamanage.dart';
import 'package:project_food_fit/pages/recipe_template.dart';
import 'package:project_food_fit/pages/recipeviewer.dart';
import 'package:project_food_fit/components/bottom_navbar.dart'; // Import the bottom_navbar.dart file
import 'package:project_food_fit/pages/favourites.dart';
void main() {
  runApp(SearchPage());
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: _buildSearchBar(),
        ),
        body: Column(
          children: [
            // Your other content here
            _buildSearchResults(),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(context), // Call the function
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Color(0xFFFF785B)),
        hintText: 'Search',
        suffixIcon: Icon(Icons.clear, color: Colors.grey),
      ),
      onChanged: (value) {
        print('Value Changed.');
      },
            onSubmitted: (value) async {
        // Handle the submitted value (user hits enter)
        print('Value Submitted.');
        print('Search Query: $value');
        final result = await fetchResource1("*", "name", "LIKE", value);
        print('Success??: $result');

        setState(() {
          searchResults = result;
        });
      },
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // Navigate to the recipe_template page with the selected recipe's ID
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDatabasePage(
                    recipeID: searchResults[index]['id'],
                  ),
                ),
              );
            },
            
            leading: CircleAvatar(
              // Assuming 'image' is a key in your searchResults
              //backgroundImage: NetworkImage(searchResults[index]['image']),
              backgroundColor: Colors.blue,
            ),
            
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(searchResults[index]['name']),
                    Text(searchResults[index]['description']),
                  ],
                ),
                Text(
                  'Difficulty: ${searchResults[index]['difficulty']}',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            // Add other details if needed
          );
        },
      ),
    );
  }
}

class CustomPlusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the RecipePage when the "+" button is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipePage()),
        );
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFF785B),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

