import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:soc_app/features/post/presentation/widgets/add_tag_widget.dart';
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
      create: (context) => getIt<PostCubit>(),
      child: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).pop();
            resetForm();
          }
          if (state.isLoading) {
            showLoading();
          } else if (state.isFailed) {}
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: SingleChildScrollView(
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
                                  image: FileImage(File(image?.path as String)),
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
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              usernames[index],
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
                      setState(() {
                        // captions. = value;
                      });
                    },
                    maxLines: 8,
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
                      ? () {
                          // final post = Post(
                          //     caption: caption,
                          //     postPic: postPic,
                          //     userId: userId);
                          // getIt<PostCubit>().createPost(post);
                        }
                      : null,
                  label: 'post!',
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
