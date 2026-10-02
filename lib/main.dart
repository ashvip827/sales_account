import 'package:flutter/material.dart';

import 'sales_screen.dart';

void main() {
  runApp(const JewelAccountsApp());
}

class JewelAccountsApp extends StatelessWidget {
  const JewelAccountsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewel Accounts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const SalesScreen(),
    );
  }
}
