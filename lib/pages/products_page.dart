import 'package:demo/models/product.dart';
import 'package:demo/state/products/products_bloc.dart';
import 'package:demo/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsPage extends StatefulWidget {
  final String? filterByCategory;

  const ProductsPage({super.key, this.filterByCategory});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController searchController = TextEditingController();
  late ProductsBloc productsBloc;
  late ProductsState state;
  late List<Product>? categorizedProducts;
  late List<Product>? products;

  @override
  void didChangeDependencies() {
    productsBloc = context.watch<ProductsBloc>();
    state = productsBloc.state;
    products = state.products;

    if (state is ProductsUpdate && widget.filterByCategory != null) {
      filterByCategory();
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    if (state is ProductsInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ProductsUpdate) {
      return CustomScrollView(
        slivers: <Widget>[
          // App Bar containing Search Field and Results indicator
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            expandedHeight: isLandscape ? 0.12.sw : 0.12.sh,
            toolbarHeight: isLandscape ? 0.12.sw : 0.12.sh,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  TextField(
                    controller: searchController,
                    onChanged: searchFilter,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Number of results indicator
                  Text("showing ${products?.length} results",
                      style: TextStyle(color: Colors.grey, fontSize: 12.spMax))
                ],
              ),
            ),
          ),

          // Products List builder
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
            sliver: SliverList.builder(
              itemBuilder: (_, index) => ProductWidget(
                key: Key("${products?[index].id.toString()}"),
                products?[index],
              ),
              itemCount: products?.length,
            ),
          ),
        ],
      );
    }

    return Center(
      child: Text(state.exception.toString()),
    );
  }

  void filterByCategory() {
    setState(() {
      categorizedProducts = state.products!
          .where((p) => p.category == widget.filterByCategory)
          .toList();
      products = categorizedProducts;
    });
  }

  void searchFilter(String text) {
    setState(() {
      if (widget.filterByCategory != null) {
        products = categorizedProducts!
            .where(
              (p) =>
                  p.title.toLowerCase().contains(text.toLowerCase()) ||
                  p.brand.toLowerCase().contains(text.toLowerCase()) ||
                  p.category.toLowerCase().contains(text.toLowerCase()) ||
                  p.description.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();
      } else {
        products = state.products!
            .where(
              (p) =>
                  p.title.toLowerCase().contains(text.toLowerCase()) ||
                  p.brand.toLowerCase().contains(text.toLowerCase()) ||
                  p.category.toLowerCase().contains(text.toLowerCase()) ||
                  p.description.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();
      }
    });
  }
}
