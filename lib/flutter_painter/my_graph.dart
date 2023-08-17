import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_for_all/flutter_painter/limit_painter.dart';

class MyLimitGraphWidget extends StatefulWidget {
  ///Must be only one line, else its clipped
  final String? heading;
  final String value;
  final bool headingInTop;
  final String percentageValueInString;
  final int percentageValue;
  const MyLimitGraphWidget({
    required this.heading,
    required this.value,
    required this.percentageValue,
    required this.percentageValueInString,
    this.headingInTop = true,
    Key? key,
  }) : super(key: key);

  @override
  State<MyLimitGraphWidget> createState() => _MyLimitGraphWidgetState();
}

class _MyLimitGraphWidgetState extends State<MyLimitGraphWidget>
    with TickerProviderStateMixin {
  ///As per the fitted size the Custom Painter is painted
  ///
  /// Warning: Do not use GenericSizeUtils or ScreenUtils package for below fitted size value
  static const double fittedSize = 300;

  late AnimationController _loadingController;
  late AnimationController _pressedController;
  late Animation<double> _loadingAnimation;
  late Animation<double> _pressedAnimation;

  @override
  void initState() {
    super.initState();
    _setLoadingAnimation();
    _setPressedAnimation();
  }

  void _setLoadingAnimation() {
    _loadingController = AnimationController(
        duration: Duration(milliseconds: _getMillisecondsDuration()),
        vsync: this)
      ..forward();
    _loadingAnimation =
        Tween<double>(begin: 0, end: widget.percentageValue.toDouble())
            .animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    ));
  }

  void _setPressedAnimation() {
    _pressedController = AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this);
    _pressedAnimation = Tween<double>(
      begin: 0,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _pressedController,
      curve: Curves.easeInOut,
    ));
  }

  int _getMillisecondsDuration() {
    if (widget.percentageValue < 25) {
      return widget.percentageValue * 50;
    } else if (widget.percentageValue > 75) {
      return widget.percentageValue * 15;
    } else {
      return widget.percentageValue * 25;
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _pressedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                if (!_pressedController.isAnimating) {
                  _pressedController
                      .forward()
                      .then((value) => _pressedController.reverse());
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                        animation: Listenable.merge([
                          _loadingAnimation,
                          _pressedAnimation,
                        ]),
                        builder: (context, child) {
                          return CustomPaint(
                            painter: CustomMyLimitPainter(
                              progressPercentage: _loadingAnimation.value,
                              offSetAnimation: _pressedAnimation.value,
                            ),
                          );
                        }),
                  ),
                  Positioned.fill(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: fittedSize * 0.175, right: fittedSize * 0.175),
                    child: Tooltip(
                      message: widget.heading ?? "",
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _HeadingNullCheckedWidget(
                            heading:
                                widget.headingInTop ? widget.heading : null,
                          ),
                          Text(
                            widget.value,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: const Color(0xFF050505),
                            ),
                          ),
                          _HeadingNullCheckedWidget(
                            heading:
                                widget.headingInTop ? null : widget.heading,
                          ),
                        ],
                      ),
                    ),
                  )),
                  Positioned.fill(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: fittedSize * 0.285, right: fittedSize * 0.285),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform.translate(
                        offset: const Offset(0, 15),
                        child: Text(
                          widget.percentageValueInString,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeadingNullCheckedWidget extends StatelessWidget {
  ///If null, shows nothing
  final String? heading;
  const _HeadingNullCheckedWidget({required this.heading, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return heading != null
        ? Text(
            heading ?? "",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color(0xFF050505),
            ),
          )
        : const SizedBox();
  }
}
