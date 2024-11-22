// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewPage extends StatefulWidget {
//   @override
//   _WebViewPageState createState() => _WebViewPageState();
// }

// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WebView App'),
//       ),
//       body: FutureBuilder<String>(
//         future: _loadLocalHtml(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return WebViewWidget(
//               initialUrl: Uri.dataFromString(
//                 snapshot.data!,
//                 mimeType: 'text/html',
//                 encoding: Encoding.getByName('utf-8')
//               ).toString(),
//               javascriptMode: JavascriptMode.unrestricted,
//               onWebViewCreated: (WebViewController webViewController) {
//                 _controller = webViewController;
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   Future<String> _loadLocalHtml() async {
//     return await rootBundle.loadString('assets/index.html');
//   }
// }
