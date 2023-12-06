import 'package:demo/models/product.dart';
import 'package:demo/state/favourites/favourites_cubit.dart';
import 'package:demo/widgets/detail_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavourite = false;
  late FavouritesCubit favouritesCubit;

  @override
  void didChangeDependencies() {
    favouritesCubit = context.watch<FavouritesCubit>();
    isFavourite = favouritesCubit.checkIsFavourite(widget.product.id);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(fontSize: 18.spMax, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.thumbnail,
              height: isLandscape ? 0.3.sw : 0.3.sh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product Details:",
                          style: TextStyle(
                            fontSize: 16.spMax,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () => favouritesCubit
                              .toggleFavourite(widget.product.id),
                          child: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color:
                                isFavourite ? Colors.redAccent : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailsRow(label: "Name:", detail: widget.product.title),
                      DetailsRow(
                          label: "Price:", detail: "${widget.product.price}"),
                      DetailsRow(
                          label: "Category:", detail: widget.product.category),
                      DetailsRow(label: "Brand:", detail: widget.product.brand),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.spMax),
                        child: Row(
                          children: [
                            Text(
                              "Rating:",
                              style: textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 36.w),
                            Row(
                              children: [
                                Text(
                                  "${widget.product.rating}",
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: Colors.black),
                                ),
                                SizedBox(width: 10.w),
                                RatingBarIndicator(
                                  rating: widget.product.rating,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 10.spMax,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      DetailsRow(
                          label: "Stock", detail: "${widget.product.stock}"),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.spMax),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description:",
                              style: textTheme.labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product.description,
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Gallery
                      Text(
                        "Product Gallery:",
                        style: textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      MasonryGridView.builder(
                        shrinkWrap: true,
                        mainAxisSpacing: 48.r,
                        crossAxisSpacing: 48.r,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (_, idx) =>
                            Image.network(widget.product.images[idx]),
                        itemCount: widget.product.images.length,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
