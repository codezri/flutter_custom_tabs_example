import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_custom_tabs_platform_interface/flutter_custom_tabs_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Tabs Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Tabs Demo'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Open GitHub', style: TextStyle(fontSize: 20)),
          onPressed: () => _launchURL(context),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    final theme = Theme.of(context);
    try {
      launch('https://h40xbnihul.execute-api.us-east-2.amazonaws.com/default/testHeaders',
        // Android Custom Tabs config
        customTabsOption: CustomTabsOption(
          showPageTitle: true,
          toolbarColor: theme.primaryColor,
          animation: CustomTabsSystemAnimation.fade(),
          // fallback options
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
          headers: {
            'content-type': 'text/plain'
          }
        ),
        // iOS Safari View Controller config
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    }
    catch(e) {
      // Handle the URL launching failure here
      debugPrint(e.toString());
    }
  }
}
