import 'package:bab_skill_assignment_task/models/news_model.dart';
import 'package:bab_skill_assignment_task/pages/own_web_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.results});

  final Results results;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.results.title}'),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.darken),
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                      image: CachedNetworkImageProvider(
                        widget.results.multimedia!.first.url!,
                        errorListener: (p0) => const Icon(Icons.error),
                      )),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${widget.results.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: const Text(
                  'Description / Abstract : ',
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Text(
                  widget.results.abstract.toString().trimLeft(),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: const Text(
                  'Author : ',
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Text(
                  widget.results.byline.toString().trimLeft(),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OwnWebView(
                                results: widget.results,
                              )));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 10, top: 10, right: 10, bottom: 10),
                  child: Text(
                    'See More',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
