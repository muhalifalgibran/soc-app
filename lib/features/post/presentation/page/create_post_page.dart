import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/utils/debouncer.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:soc_app/features/post/presentation/cubits/tag_cubit.dart';
import 'package:soc_app/features/post/presentation/widgets/add_tag_widget.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/your_page/presentation/cubits/your_page_cubit.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  XFile? image;
  TextEditingController captions = TextEditingController();
  List<String> usernames = [];

  final ImagePicker picker = ImagePicker();
  final _tagCubit = getIt<TagCubit>();

  bool isOpenMention = false;
  String mentioned = '';

  final Debouncer _debounce = Debouncer(const Duration(milliseconds: 300));

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void resetForm() {
    setState(() {
      image = null;
      captions.text = '';
      usernames.clear();
    });
  }

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isResetActive =
        image?.path != null || usernames.isNotEmpty || captions.text != '';
    return BlocProvider(
      create: (context) => _tagCubit,
      child: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).pop();
            resetForm();
            context.read<ProfileCubit>()
              ..getPosts()
              ..getProfile();
            context.read<YourPageCubit>().getYourPage();
          }
          if (state.isLoading) {
            showLoading();
          } else if (state.isFailed) {}
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'post something..',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        // display reset if there is image
                        isResetActive
                            ? GestureDetector(
                                onTap: resetForm,
                                child: const Icon(Icons.replay_outlined))
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Image Upload
                    GestureDetector(
                      onTap: () {
                        showImageDialog(context);
                      },
                      child: NeuContainer(
                        child: image?.path != null
                            ? Container(
                                height: 190,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(image?.path as String)),
                                    )),
                              )
                            : const SizedBox(
                                height: 190,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 36,
                                    ),
                                    Text('|'),
                                    Icon(
                                      Icons.image,
                                      size: 36,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // add tags
                    usernames.isNotEmpty
                        ? Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(
                              usernames.length,
                              (index) => Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '@${usernames[index]}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    AddTagWidget(
                      tags: (tags) {
                        setState(() {
                          usernames = tags;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    // add captions
                    NeuContainer(
                      border: Border.all(),
                      child: TextField(
                        controller: captions,
                        onChanged: (value) {
                          // trigger the container if the
                          if (value != '') {
                            var lastWord = value.split('').last;
                            if (lastWord == '@') {
                              setState(() {
                                isOpenMention = true;
                              });
                            } else if (isOpenMention == true &&
                                lastWord == ' ') {
                              // make it invicible when undo
                              setState(() {
                                isOpenMention = false;
                              });
                            }
                            // pattern to get from @ until first space
                            RegExp regex = RegExp(r'@([^ ]+)');

                            // Find the fist that match
                            Iterable<Match>? matches = regex.allMatches(value);

                            for (Match match in matches) {
                              String? username = match.group(1);
                              _debounce.call(() {
                                _tagCubit.getTags(username ?? '');
                              });
                            }
                          } else {
                            setState(() {
                              isOpenMention = false;
                            });
                          }
                          setState(() {});
                        },
                        maxLines: 4,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'write your caption..',
                        ),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // button
                    SocButton(
                      onPressed: image?.path != null && (captions.text != '')
                          ? () async {
                              var box = await Hive.openBox('userStatus');
                              var userId = box.get('userUid');
                              var username = box.get('username');
                              box.close();

                              final post = Post(
                                  caption: captions.text,
                                  postPic: image?.path ?? '',
                                  tags: usernames != [] ? usernames : null,
                                  username: username,
                                  userId: userId);
                              getIt<PostCubit>().createPost(post);
                            }
                          : null,
                      label: 'post!',
                    ),
                  ],
                ),
              ),
              // Container for the mentioned usernames
              Visibility(
                visible: isOpenMention,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 300,
                    width: 280,
                    padding: const EdgeInsets.all(8),
                    child: BlocProvider(
                      create: (context) => _tagCubit,
                      child: BlocBuilder<TagCubit, TagState>(
                        bloc: _tagCubit,
                        builder: (context, state) {
                          return mentionUsernames(state);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mentionUsernames(TagState state) {
    if (state.usernames != null) {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(
            state.usernames!.length,
            (index) => GestureDetector(
              onTap: () {
                // Regex pattern start from last until first space from last
                RegExp regex = RegExp(r'\S+\s\@\w+$');

                // Pola regex untuk mencocokkan dari akhir string hingga spasi pertama
                RegExp regexGetLastWord = RegExp(r' (\S+)$');

                RegExpMatch? match = regexGetLastWord.firstMatch(captions.text);

                if (match != null) {
                  String? substring = match.group(1);
                  String newText = replaceText(captions.text, substring ?? '',
                      '@${state.usernames![index]}');
                  captions.text = newText;
                } else {
                  print("No Match");
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Text('@${state.usernames![index]}'),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  void showImageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Take an image')),
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Upload from your galery'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String replaceText(String text, String toReplace, String newWord) {
    return text.replaceAll(toReplace, newWord);
  }
}
