import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/wrapper.dart';
import 'state/products/products_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductsUpdate:
            Future.delayed(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const Wrapper())),
            );
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/splash.png",
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.15.sw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "My Store",
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle
                        ?.copyWith(fontSize: 48.spMax),
                  ),
                  SizedBox(height: 32.h),
                  Column(
                    children: [
                      Text(
                        "Valkommen",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
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
