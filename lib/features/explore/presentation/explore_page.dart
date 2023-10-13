import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(100, (index) {
          return _PeopleList();
        })),
      ),
    );
  }
}

class _PeopleList extends StatelessWidget {
  const _PeopleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('@gwencanayo'),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 18,
            ),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Follow'),
          )
        ],
      ),
    );
  }
}
