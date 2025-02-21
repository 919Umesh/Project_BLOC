import 'package:flutter/material.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double appBarHeight = constraints.maxHeight;
                    double opacity = 1.0 - ((appBarHeight - kToolbarHeight) / (200.0 - kToolbarHeight)).clamp(0.0, 1.0);
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 300),
                        child: const Text(
                          "Product List",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      background: Image.asset(
                        'assets/images/PhotoBloc_3.jpg',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              // SliverAppBar(
              //   floating: true,
              //   expandedHeight: 80,
              //   backgroundColor: Colors.purple[900],
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Padding(
              //       padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: Container(
              //               height: 40,
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                   hintText: 'Search products',
              //                   prefixIcon: const Icon(Icons.search),
              //                   suffixIcon: IconButton(
              //                     icon: const Icon(Icons.camera_alt_outlined),
              //                     onPressed: () {},
              //                   ),
              //                   border: InputBorder.none,
              //                   contentPadding:
              //                   const EdgeInsets.symmetric(horizontal: 16),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //           Container(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 12, vertical: 8),
              //             decoration: BoxDecoration(
              //               color: Colors.green,
              //               borderRadius: BorderRadius.circular(4),
              //             ),
              //             child: const Text(
              //               'Pay',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   floating: true,
              //   expandedHeight: 80,
              //   backgroundColor: Colors.purple[900],
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: Padding(
              //       padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: Container(
              //               height: 40,
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                   hintText: 'Search products',
              //                   prefixIcon: const Icon(Icons.search),
              //                   suffixIcon: IconButton(
              //                     icon: const Icon(Icons.camera_alt_outlined),
              //                     onPressed: () {},
              //                   ),
              //                   border: InputBorder.none,
              //                   contentPadding:
              //                       const EdgeInsets.symmetric(horizontal: 16),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //           Container(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 12, vertical: 8),
              //             decoration: BoxDecoration(
              //               color: Colors.green,
              //               borderRadius: BorderRadius.circular(4),
              //             ),
              //             child: const Text(
              //               'Pay',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
