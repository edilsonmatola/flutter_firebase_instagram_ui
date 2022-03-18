import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  }) : super(key: key);

// To display (the child of the animation)
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  @override
  _LikeAnimationState createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController likeAnimationController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    likeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/
            2, //Dividing the duration by 2 and converting into int
      ),
    );
    //
    scale = Tween<double>(begin: 1, end: 1.2).animate(likeAnimationController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  Future startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await likeAnimationController.forward();
      await likeAnimationController.reverse();
      await Future.delayed(
        const Duration(
          milliseconds: 200,
        ),
      );

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    likeAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
