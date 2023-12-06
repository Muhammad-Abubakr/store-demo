import 'package:demo/pages/products_page.dart';
import 'package:demo/state/categories/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController searchController = TextEditingController();
  late CategoriesBloc categoriesBloc;
  late CategoriesState state;
  late List<String>? categories;

  @override
  void didChangeDependencies() {
    categoriesBloc = context.watch<CategoriesBloc>();
    state = categoriesBloc.state;
    categories = state.categories;

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

    if (state is CategoriesInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CategoriesUpdate) {
      return CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: isLandscape ? 0.12.sw : 0.12.sh,
          toolbarHeight: isLandscape ? 0.12.sw : 0.12.sh,
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  onChanged: filterProducts,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 20.h),
                Text("showing ${state.categories?.length} results",
                    style: TextStyle(color: Colors.grey, fontSize: 12.spMax))
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: categories?.length,
            itemBuilder: (_, idx) => Padding(
              key: Key(
                  state.firstOfCategories![categories![idx]]!.id.toString()),
              padding: EdgeInsets.all(isLandscape ? 24.spMax : 12.spMax),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text(
                          categories![idx],
                          style: TextStyle(
                              fontSize: 24.spMax, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: ProductsPage(filterByCategory: categories![idx]),
                    ),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Category Image
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(isLandscape ? 48.r : 24.r)),
                      child: Image.network(
                        state.firstOfCategories![categories![idx]]!.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Shadow for readability
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(isLandscape ? 48.r : 24.r)),
                          color: Colors.black26),
                    ),

                    // Category Label
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.spMax, vertical: 28.spMax),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          toUpperCaseFirst(
                            categories![idx],
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.spMax,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]);
    } else {
      return Center(
        child: Text("${state.exception}"),
      );
    }
  }

  // helper functions
  String toUpperCaseFirst(String text) =>
      text.replaceRange(0, 1, text.toUpperCase().substring(0, 1));

  void filterProducts(String value) {
    setState(() {
      categories = state.categories!.where((c) => c.contains(value)).toList();
    });
  }
}
