import 'package:flutter/material.dart';
import 'package:project_food_fit/components/datamanage.dart';
import 'home.dart';
import 'profile.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Color(0xFFFF785B)),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: CustomPlusIcon(),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.grey),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person, color: Colors.grey),
                onPressed: () {
                  // Navigate to the profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              label: '',
            ),
          ],
        ),
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
    return Container(
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
    );
  }
}
