// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_library/app/mahas/extension/box_extension.dart';
import 'package:movie_library/app/mahas/services/mahas_format.dart';

import '../../../mahas/mahas_config.dart';
import '../controllers/detail_movie_controller.dart';

class DetailMovieView extends GetView<DetailMovieController> {
  const DetailMovieView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoad.value == false
          ? Scaffold(
              backgroundColor: Colors.grey[900],
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            )
          : Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                // title: const Text("Dashboard"),
                actions: const [],
              ),
              body: Stack(
                children: [
                  Stack(
                    children: [
                      Obx(() => controller.isLoad.value == false
                          ? const SizedBox()
                          : Image.network(
                              "${MahasConfig.urlImage}/t/p/w600_and_h900_bestv2/${controller.movie.value!.posterPath}",
                              width: 600.0,
                              height: 900.0,
                              fit: BoxFit.cover,
                            )),
                      ClipRRect(
                        // Clip it cleanly.
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black87,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 330,
                              width: 220,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${MahasConfig.urlImage}/t/p/w220_and_h330_face/${controller.movie.value!.posterPath}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black87,
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  )
                                ],
                                color: Colors.grey,
                              ),
                            ),
                            10.heightBox,
                            Container(
                              // height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  // color: Colors.blue,
                                  ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      controller.movie.value!.title ?? "",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  5.heightBox,
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " ${controller.movie.value!.runtime!} ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "minutes",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      30.widthBox,
                                      const Icon(
                                        Icons.star,
                                        size: 16.0,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        " ${NumberFormat("0.#").format(controller.movie.value!.voteAverage!)} ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  20.heightBox,
                                  const Text(
                                    "Release date",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  5.heightBox,
                                  Text(
                                    MahasFormat.displayDate(
                                        controller.movie.value!.releaseDate!),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  5.heightBox,
                                  const Text(
                                    "Genre",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  5.heightBox,
                                  SizedBox(
                                    height: 32.0,
                                    child: ListView.builder(
                                      itemCount: controller
                                          .movie.value!.genres!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var item = controller
                                            .movie.value!.genres![index];
                                        bool selected = index == 99;

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          decoration: BoxDecoration(
                                            color: selected
                                                ? Colors.orange
                                                : Colors.grey[900],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${item.name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  20.heightBox,
                                  const Text(
                                    "Synopsis",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  5.heightBox,
                                  Text(
                                    "${controller.movie.value!.overview!} ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  20.heightBox,
                                  const Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${MahasFormat.toCurrency(
                                      controller.movie.value!.revenue!
                                          .toDouble(),
                                    )}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
