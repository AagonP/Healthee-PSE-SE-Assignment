import 'package:flutter/material.dart';
import '../providers/data_helper.dart';
import '../providers/list_of_entry.dart';
String searchKey;

class SearchInput extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    FoodData foodData = FoodData();
    print('suggestion called');
    final suggestionList = query.isEmpty
        ? suggestion
        : suggestion.where((e) => e.startsWith(query.toLowerCase())).toList();
    print(suggestionList.length);
    return suggestionList.isEmpty
        ? ListTile(
            leading: Icon(Icons.do_not_disturb_alt),
            title: Text(
              'Not found',
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () async {
                await foodData.getRecipe(context, suggestionList[index]);
                searchKey = suggestionList[index];
                Navigator.pop(context);
              },
              leading: Icon(Icons.fastfood),
              title: RichText(
                text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: suggestionList.length,
          );
  }
}
