import 'package:flutter/material.dart';
class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final  Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  const LikeAnimation({super.key,
  required this.child,
  required this.isAnimating,
   this.duration= const Duration(milliseconds: 150),
  required this.onEnd,
  this.smallLike=false,});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller ;
 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds:150 ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}