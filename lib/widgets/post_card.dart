import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/colors_util.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.snap}) : super(key: key);

  final snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // * ====== HEADER SECTION ==============
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(
              right: 0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profileImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          snap['username'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        children: [
                          'Delete',
                        ]
                            .map(
                              (e) => InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  child: Text(e),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),
          // * ===== IMAGE SECTION ========
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .35,
            child: Image.network(
              snap['postUrl'].toString(),
              fit: BoxFit.cover,
            ),
          ),

          // * ========= LIKE, COMMENT SECTION ==========
          Row(
            children: [
              // * Like
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              // * Comment
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              // * Share
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // *==== Description & Comments Section ======
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  child: snap['likes'].length == 1
                      ? Text(
                          "${snap['likes'].length.toString()} like",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      : Text(
                          "${snap['likes'].length.toString()} likes",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${snap['description'].toString()}',
                        ),
                      ],
                    ),
                  ),
                ),
                // * ==== Comments =====
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all 200 comments',
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      (snap['datePublished'] as Timestamp).toDate(),
                    ),
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
