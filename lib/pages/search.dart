import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class SearchPage extends StatefulWidget {
  String query;

  SearchPage({super.key, this.query = ''});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isLoading = true;
  List<Product> _products = [];
  List<Product> searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchProductsFromHive();
    _fetchProductsFromHive().then((_) {
      _getSearchResults(widget.query);
    });
  }

  Future<void> _fetchProductsFromHive() async {
    List<Product> products = await ProductApiHandler().getProducts();
    setState(() {
      _products = products;
    });
    _isLoading = false;
  }

  void _getSearchResults(String querySearch) async {
    _isLoading = true;
    setState(() {
      widget.query = querySearch;
      searchResults = _products
          .where((product) =>
              product.title.toLowerCase().contains(widget.query.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: whiteMain,
        backgroundColor: whiteMain,
        title: _buildSearchField(),
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : searchResults.isEmpty
                ? Center(child: Text('No results found for "${widget.query}"'))
                : GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height * 0.68),
                    children: List.generate(searchResults.length, (index) {
                      Map<String, dynamic> productItem =
                          searchResults[index].toJson();
                      return ProductItem(product: productItem);
                    }),
                  ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: gray50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.search, color: gray600),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: widget.query.isNotEmpty ? widget.query : 'Search',
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              onSubmitted: (value) => _getSearchResults(value),
            ),
          ),
        ],
      ),
    );
  }
}
