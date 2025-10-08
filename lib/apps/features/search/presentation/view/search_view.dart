import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../controller/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('SearchView'.tr), centerTitle: true),
        body: const SafeArea(
          child: Text('SearchView is working', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
