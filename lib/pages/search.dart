import 'package:flutter/material.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> formattedProducts = getFormattedPr oducts();
    List<Map<String, dynamic>> searchResults = formattedProducts.where((product) {
      return product['title'] != null && product['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Debug print to check the search results
    print('Search Results: $searchResults');

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$query"'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: searchResults.isEmpty
            ? Center(child: Text('No results found for "$query"'))
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height * 0.68),
                children: List.generate(searchResults.length, (index) {
                  final product = searchResults[index];
                  return ProductItem(product: product);
                }),
              ),
      ),
    );
  }
}