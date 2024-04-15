import 'package:bab_skill_assignment_task/constants/constants.dart';
import 'package:bab_skill_assignment_task/models/news_model.dart';
import 'package:bab_skill_assignment_task/providers/news_provider.dart';
import 'package:bab_skill_assignment_task/providers/internet_connectivity.dart';
import 'package:bab_skill_assignment_task/widgets/grid_news_card.dart';
import 'package:bab_skill_assignment_task/widgets/news_card.dart';
import 'package:bab_skill_assignment_task/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NewsModel news = ref.watch(newsProvider).newsModel;
    bool isLoading = ref.watch(newsProvider).isLoading;
    bool isListNews = ref.watch(newsProvider).isList;
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(child: SearchField()),
            PopupMenuButton<String>(
              color: backgroundColor,
              onSelected: (String value) {
                ref
                    .read(newsProvider.notifier)
                    .updateNewsFilter(value == '1' ? true : false);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '1',
                  child: Text('By Name'),
                ),
                const PopupMenuItem<String>(
                  value: '2',
                  child: Text('By Author'),
                ),
              ],
              icon: Icon(Icons.filter_alt_outlined),
            ),
            // IconButton(
            //     padding: EdgeInsets.zero,
            //     alignment: Alignment.center,
            //     onPressed: () {
            //       ref.read(newsProvider.notifier).updateNewsFilter(false);
            //     },
            //     icon: Icon(Icons.filter_alt_outlined)),
            IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: () {
                  ref.read(newsProvider.notifier).updateNewsStructure(true);
                },
                icon: const Icon(Icons.list_alt_rounded)),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  ref.read(newsProvider.notifier).updateNewsStructure(false);
                },
                icon: const Icon(Icons.grid_view_outlined))
          ],
        ),
        isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : connectivityStatusProvider == ConnectivityStatus.isDisonnected
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent)),
                    height: MediaQuery.of(context).size.height * 0.8,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/gif/nointernet.gif'),
                        const Center(
                            child: Text('No Internet Connectivity',
                                style: TextStyle(fontSize: 22))),
                      ],
                    ),
                  )
                : isListNews
                    ? Expanded(
                        child: news.results!.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Records Round",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : ListView.builder(
                                itemCount: news.results!.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return NewsCard(
                                      results: news.results![index]);
                                },
                              ),
                      )
                    : Expanded(
                        child: news.results!.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Records Round",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 1,
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .aspectRatio /
                                            0.8),
                                itemCount: news.results!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GridNewsCard(
                                      results: news.results![index]);
                                },
                              ),
                      )
      ])),
    );
  }
}
