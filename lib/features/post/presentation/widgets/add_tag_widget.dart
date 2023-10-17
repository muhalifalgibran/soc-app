import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/post/presentation/cubits/tag_cubit.dart';
import 'package:soc_app/widgets/soc_button.dart';

import '../../../../core/utils/debouncer.dart';

class AddTagWidget extends StatefulWidget {
  const AddTagWidget({required this.tags, super.key});

  final Function(List<String> tags) tags;

  @override
  State<AddTagWidget> createState() => _AddTagWidgetState();
}

class _AddTagWidgetState extends State<AddTagWidget> {
  final cubit = getIt<TagCubit>();

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
    final Debouncer debounce = Debouncer(const Duration(milliseconds: 300));
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: BlocProvider<TagCubit>(
            create: (context) => cubit,
            child: BlocBuilder<TagCubit, TagState>(
              bloc: cubit,
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  // set height by ratio of height
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          initialValue: '',
                          onChanged: (value) {
                            valueAdd = value;
                            // with debouncer so we're not calling our API
                            // per word. it will be much efficient
                            debounce.call(
                              () => cubit.getTags(value),
                            );
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
                      if (state.usernames != null && state.isSuccess)
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              state.usernames!.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  usernames.add(state.usernames![index]);
                                  widget.tags(usernames);
                                  Navigator.of(context).pop();
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
                                        child:
                                            Text('@${state.usernames![index]}'),
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
                        )),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
