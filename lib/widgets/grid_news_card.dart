import 'package:bab_skill_assignment_task/models/news_model.dart';
import 'package:bab_skill_assignment_task/pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class GridNewsCard extends StatelessWidget {
  final Results results;
  const GridNewsCard({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      results: results,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
              fit: BoxFit.cover,
              isAntiAlias: true,
              image: CachedNetworkImageProvider(
                results.multimedia!.first.url!,
                errorListener: (p0) => Icon(Icons.error),
              )),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(
              results.title.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              results.byline.toString().trimLeft(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
