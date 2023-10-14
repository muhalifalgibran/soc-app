import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soc_app/features/post/presentation/widgets/add_tag_widget.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:camera/camera.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  XFile? image;
  String? filePath;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      filePath = image?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Post Something..',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // display reset if there is image
                filePath != null
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            filePath = null;
                          });
                        },
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
                child: filePath != null
                    ? Container(
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(filePath as String)),
                            )),
                      )
                    : Container(
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
            AddTagWidget(
              tags: (tags) {},
            )
          ],
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
