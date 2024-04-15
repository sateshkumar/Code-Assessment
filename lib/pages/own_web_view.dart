import 'package:bab_skill_assignment_task/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OwnWebView extends StatefulWidget {
  const OwnWebView({super.key, required this.results});

  final Results results;

  @override
  State<OwnWebView> createState() => _OwnWebViewState();
}

class _OwnWebViewState extends State<OwnWebView> {
  WebViewController? webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('${widget.results.url}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.results.title}'),
        ),
        body: WebViewWidget(controller: webViewController!));
  }
}
