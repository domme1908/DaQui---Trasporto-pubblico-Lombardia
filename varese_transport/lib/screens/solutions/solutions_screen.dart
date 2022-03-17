import 'package:flutter/material.dart';
import 'package:varese_transport/screens/solutions/components/body.dart';

class SolutionsScreen extends StatefulWidget {
  const SolutionsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SolutionsScreenState();
  }
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
