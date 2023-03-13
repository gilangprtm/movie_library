import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_library/app/mahas/extension/box_extension.dart';

import '../../../mahas/mahas_config.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Container(
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
              Expanded(
                child: TextFormField(
                  initialValue: null,
                  decoration: InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "Search Movie",
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    hoverColor: Colors.transparent,
                  ),
                  onFieldSubmitted: (value) {
                    controller.getData(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoad.value == false
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: 1.0,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 320,
                  ),
                  itemCount: controller.movies.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.movies[index];
                    // print(index == controller.itemLenght - 1);
                    if (controller.isGetAgain.value == false) {
                      if (index == controller.movies.length - 1) {
                        controller.getDataAgain();
                      }
                    }
                    var vote = NumberFormat("0.#").format(item.voteAverage);
                    return InkWell(
                      onTap: () {
                        controller.toDetail(item.id!);
                      },
                      child: Container(
                        width: 180,
                        height: 230,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${MahasConfig.urlImage}/t/p/w220_and_h330_face/${item.posterPath}",
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
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    12.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: Text(
                                  item.title ?? item.name!,
                                  overflow: TextOverflow.ellipsis,
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
    );
  }
}
