import 'package:flutter/material.dart';
import 'package:soc_app/widgets/soc_button.dart';

class AddTagWidget extends StatefulWidget {
  const AddTagWidget({required this.tags, super.key});

  final Function(List<String> tags) tags;

  @override
  State<AddTagWidget> createState() => _AddTagWidgetState();
}

class _AddTagWidgetState extends State<AddTagWidget> {
  List<String> usernames = [];
  final _formKey = GlobalKey<FormState>();
  String? valueAdd;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            SocButton(
              height: 30,
              width: 100,
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 250), () {
                  addTagDialog(context);
                });
              },
              label: '@ add tag',
              labelStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }

  void addTagDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(12),
            // set height by ratio of height
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    onChanged: (value) {
                      valueAdd = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      } else if (!value.contains(RegExp(r'^@[^@]*$'))) {
                        return 'Please valid username';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SocButton(
                  width: 80,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (valueAdd != null) {
                        Navigator.of(context).pop();
                        setState(() {
                          usernames.add(valueAdd!);
                        });
                        widget.tags(usernames);
                      }
                    }
                  },
                  label: 'add',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
