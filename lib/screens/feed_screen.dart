import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/widgets/post_card.dart';
import '../utils/colors_util.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          height: 32,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: PostCard(),
    );
  }
}
