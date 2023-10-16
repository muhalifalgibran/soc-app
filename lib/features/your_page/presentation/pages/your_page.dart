import 'package:flutter/material.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_form.dart';

import '../../../../widgets/soc_button.dart';

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(100, (index) {
          return const _ListPost();
        })),
      ),
    );
  }
}

class _ListPost extends StatelessWidget {
  const _ListPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              '@alifalgibran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          Container(
            height: 320,
            color: Colors.grey.shade300,
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
                'ini captionnya untung ada itu  tawwana hahaha @alifalgibran'
                ' lorem ipsum doler amat'),
          ),
        ],
      ),
    );
  }
}
