import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_library/app/mahas/extension/box_extension.dart';
import 'package:movie_library/app/mahas/mahas_config.dart';
import 'package:shimmer/shimmer.dart';

import '../../../mahas/mahas_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Obx(() => controller.isLoad.value == false
                    ? const SizedBox()
                    : Image.network(
                        "${MahasConfig.urlImage}/t/p/w600_and_h900_bestv2/${controller.trend[0].posterPath}",
                        width: 600.0,
                        height: 900.0,
                        fit: BoxFit.cover,
                      )),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    100.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "On Popular Today",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.toListPopular();
                          },
                          child: const Text(
                            "see more",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.isLoad.value == false
                          ? Shimmer.fromColors(
                              baseColor: MahasColors.dark.withOpacity(.1),
                              highlightColor: MahasColors.dark.withOpacity(.05),
                              child: Container(
                                width: 355,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  color: Colors.grey[900],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: ScrollController(),
                              child: Obx(
                                () => Row(
                                  children: List.generate(
                                    controller.trend.length,
                                    (index) {
                                      var item = controller.trend[index];
                                      var vote = NumberFormat("0.#")
                                          .format(item.voteAverage);

                                      return InkWell(
                                        onTap: () {
                                          controller.toDetail(item.id!);
                                        },
                                        child: Container(
                                          width: 355,
                                          height: 200,
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "${MahasConfig.urlImage}/t/p/w355_and_h200_face/${item.posterPath}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, 1),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                              )
                                            ],
                                            color: Colors.grey[900],
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      12.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      vote.toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    2.widthBox,
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black87,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(16.0),
                                                      bottomRight:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    item.originalTitle ??
                                                        item.name!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                    ),
                    20.heightBox,
                    const Text(
                      "Genre",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    10.heightBox,
                    SizedBox(
                      height: 32.0,
                      child: Obx(() => ListView.builder(
                            itemCount: controller.genres.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var item = controller.genres[index];
                              return InkWell(
                                onTap: () {
                                  controller.selected.value = index;
                                  controller.getMovie(item.id!);
                                },
                                child: Obx(() => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      decoration: BoxDecoration(
                                        color:
                                            index == controller.selected.value
                                                ? Colors.orangeAccent
                                                : Colors.black26,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.name!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Movie",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.toListMovieGenre();
                          },
                          child: const Text(
                            "see more",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => controller.isLoad.value == false
                          ? Shimmer.fromColors(
                              baseColor: MahasColors.dark.withOpacity(.1),
                              highlightColor: MahasColors.dark.withOpacity(.05),
                              child: Container(
                                width: 220,
                                height: 330,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  color: Colors.grey[900],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: ScrollController(),
                              child: Obx(
                                () => Row(
                                  children: List.generate(
                                    controller.movies.length,
                                    (index) {
                                      var item = controller.movies[index];
                                      return InkWell(
                                        onTap: () {
                                          controller.toDetail(item.id!);
                                        },
                                        child: Container(
                                          width: 220,
                                          height: 330,
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "${MahasConfig.urlImage}/t/p/w220_and_h330_face/${item.posterPath}",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, 1),
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                              )
                                            ],
                                            color: Colors.grey[900],
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.orangeAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      12.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      item.voteAverage
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    2.widthBox,
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black87,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(16.0),
                                                      bottomRight:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    item.title ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              height: 90,
              // width: 100,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.only(
                  // Radius.circular(20.0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Image.asset(
                        "assets/images/logo-white.png",
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        "Movie Library",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                  // 20.heightBox,
                  InkWell(
                    onTap: () {
                      controller.toSearch();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            "Search Movie",
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
