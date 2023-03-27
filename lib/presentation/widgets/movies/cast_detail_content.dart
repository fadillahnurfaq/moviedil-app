import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_yuk/domain/entities/cast_detail_entity.dart';
import 'package:flutter/material.dart';

import '../../../state_util.dart';
import '../../../utils/constants.dart';

class CastDetailContent extends StatelessWidget {
  final CastDetailEntity data;
  const CastDetailContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "$baseImageUrl${data.profilePath}",
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 56.0),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 4.0,
                          width: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.name!,
                        style: kHeading5,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Age"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                data.birthday == null
                                    ? "Empty Data"
                                    : convertBirtdayToAge(data.birthday!),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Born in"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  data.placeOfBirth == null
                                      ? "Empty Data"
                                      : data.placeOfBirth!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Biography",
                        style: kHeading6,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.biography == null ? "Empty Data" : data.biography!,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: kRichBlack,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const SizedBox(
                height: 40.0,
                width: 40.0,
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  static String convertBirtdayToAge(String birthday) {
    final date = DateTime.parse(birthday);
    final now = DateTime.now();
    final difference = now.difference(date);
    final age = difference.inDays ~/ 365;
    return '$age years old';
  }
}
