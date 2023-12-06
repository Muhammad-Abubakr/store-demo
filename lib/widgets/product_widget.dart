import 'package:demo/models/product.dart';
import 'package:demo/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductWidget extends StatelessWidget {
  final Product? _product;

  const ProductWidget(Product? product, {super.key}) : _product = product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: _product!),
        ),
      ),
      child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
          child: _product != null
              ? Padding(
                  padding:
                      EdgeInsets.only(left: 48.w, right: 48.w, bottom: 48.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(16.r),
                            ),
                            child: Image.network(
                              _product!.thumbnail,
                              height: 170,
                              width: 320,
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              _product!.title,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("\$${_product!.price}",
                                textAlign: TextAlign.right,
                                style: textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${_product!.rating}",
                            style: textTheme.titleSmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.spMax,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          RatingBarIndicator(
                            rating: _product!.rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 10.spMax,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "By ${_product!.brand}",
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 10.spMax,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "In ${_product!.category}",
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 10.spMax,
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
