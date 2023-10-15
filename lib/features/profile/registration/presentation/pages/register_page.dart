import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/core/utils/domain/entities/user_data.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/register_cubit.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_circular_image.dart';
import 'package:soc_app/widgets/soc_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  XFile? image;

  final ImagePicker picker = ImagePicker();
  String? username;
  String? password;
  String? email;

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const NeuContainer(
                backgroundColor: Colors.black54,
                child: Text(
                  'Register your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: NeuContainer(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showImageDialog(context);
                      },
                      child: SocCircularImage(
                        height: 72,
                        width: 72,
                        child: image?.path != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(72 * 0.5),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(
                                child: Text(
                                  'add avatar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SocForm(
                      label: 'Email',
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SocForm(
                      label: 'Username',
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SocForm(
                      label: 'Password',
                      obscure: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SocButton(
              onPressed:
                  (username != null) || (password != null) || (email != null)
                      ? () {
                          print('image pathnya ${image?.path}');
                          UserData userData = UserData(
                            email: email!,
                            password: password!,
                            picPath: image?.path,
                            username: username!,
                          );
                          // if (image?.path != null) {
                          //   userData.copyWith(picPath: image!.path);
                          // }
                          getIt<RegisterCubit>().createUser(userData);
                        }
                      : null,
              label: 'Register',
              color: Colors.blue.shade100,
            ),
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
