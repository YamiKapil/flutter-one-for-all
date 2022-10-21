
import "package:flutter/material.dart";

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() =>
      _AnimatedImageState();
}
class _AnimatedImageState extends State<AnimatedImage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.1,0))
        .animate(_animationController);
    _animationController.forward().whenComplete(() {
      // when animation completes, put your code here
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            // left = x value, top = y value;
            // to set last position (50,10) top:50, left:10, end _animation Offset.zero
            Positioned(
              top: 50,
              left: 10,
              child: SlideTransition(
                position: _animation,
                child: AnimatedContainer(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  duration: Duration(seconds: 0),
                  child: Image(
                    height: 50,
                    width: 50,
                    image: AssetImage('assets/images/yami.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}