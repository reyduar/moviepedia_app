import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search movie by name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Results!!');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('Suggestions!!');
  }
}
