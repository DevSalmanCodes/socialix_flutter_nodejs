import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/core/utils/pick_image.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_button.dart';
import 'package:socialix_flutter_nodejs/core/widgets/custom_text_field.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/create_post_cubit.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/create_post_state.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final TextEditingController contentController = TextEditingController();
  File? file;

  Future<void> _onUploadImageTapped(BuildContext context) async {
    final res = await pickImage();
    if (res != null && res.isNotEmpty) {
      context.read<CreatePostCubit>().updateImage(res);
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Post"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CreatePostCubit, CreatePostState?>(
          listener: (context, state) {
            if (state is CreatePostSuccessState) {
              showToast('Post created successfully!');
              context.pop();
            } else if (state is CreatePostErrorState) {
              showToast(state.message.toString());
            } else if (state is CreatePostInitialState) {
              file = state.file!;
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: "What's on your mind?",
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _onUploadImageTapped(context),
                  child: Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.primaryColor.withOpacity(0.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child:
                        file == null
                            ? Text(
                              "Tap to upload image",
                              style: textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            )
                            : Image.file(
                              File(file!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                  ),
                ),

                const SizedBox(height: 24),

                CustomButton(
                  onTap:
                      () => context.read<CreatePostCubit>().createPost(
                        contentController.text.trim(),
                        file?.path,
                      ),
                  text: 'Post',
                  isLoading: state is CreatePostLoadingState,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
