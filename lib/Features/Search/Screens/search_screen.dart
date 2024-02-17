import 'package:amazon_clone_with_nodejs/Common/Widgets/loader.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Widgets/address_box.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:amazon_clone_with_nodejs/Features/Product_details/Screens/product_detail_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Search/Services/search_service.dart';
import 'package:amazon_clone_with_nodejs/Features/Search/Widgets/searched_product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchService _searchService = SearchService();

  List<Product>? searchedProducts;

  fetchSearchedData(String searchQuery) async {
    searchedProducts = await _searchService.fetchSearchProduct(
      context: context,
      searchQuery: searchQuery,
    );
    setState(() {});
  }

  navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQuery,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchSearchedData(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: (searrchQuery) => navigateToSearchScreen(searrchQuery),
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: searchedProducts == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedProducts!.length,
                    itemBuilder: (context, index) {
                      final product = searchedProducts![index];

                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: product,
                        ),
                        child: SearchedProduct(product: product),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
