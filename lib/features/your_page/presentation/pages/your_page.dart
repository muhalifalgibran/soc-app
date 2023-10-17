import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/your_page/presentation/cubits/your_page_cubit.dart';

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  late YourPageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<YourPageCubit>();
    _cubit.getYourPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: BlocBuilder<YourPageCubit, YourPageState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.isSuccess) {
            // show post
            if (state.posts != []) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    state.posts!.length,
                    (index) {
                      return _ListPost(
                        state.posts![index],
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Follow or make a posts..'),
              );
              // show empty post
            }
          }
          return Container();
        },
      ),
    );
  }
}

class _ListPost extends StatelessWidget {
  const _ListPost(this.post);
  final Post post;
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
            child: Text(
              '@${post.username}',
              style: const TextStyle(
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
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            child: Image.network(
              post.postPic,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          if (post.tags!.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_2_outlined,
                    size: 18,
                  ),
                  Row(
                      children: List.generate(
                    post.tags!.length,
                    (index) => Text(
                      '@${post.tags![index]} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: post.username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: ': '),
                    TextSpan(text: post.caption),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
