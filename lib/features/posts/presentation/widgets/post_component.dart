import 'package:flutter/material.dart';
import 'package:posts_app_flutter/core/widgets/body_text.dart';
import 'package:posts_app_flutter/core/widgets/title_text.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

class PostComponent extends StatelessWidget {
  final Post post;
  const PostComponent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/post-details', arguments: post);
      },
      child: ListTile(
          title: TitleText(title: post.title),
          subtitle: BodyText(body: post.body)),
    );
  }
}
