import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:sire/core/constant/color.dart';
import 'package:vibration/vibration.dart';

class MovingGradientReviewButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const MovingGradientReviewButton({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  MovingGradientReviewButtonState createState() =>
      MovingGradientReviewButtonState();
}

class MovingGradientReviewButtonState extends State<MovingGradientReviewButton>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _tapController;
  late AnimationController _starController;
  late AnimationController _sparkleFadeController;

  late Animation<double> _gradientPosition;
  late Animation<double> _scaleAnimation;
  late Animation<double> _starBounce;
  late Animation<double> _starRotation;

  OverlayEntry? _sparkleOverlay;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _sparkleFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _gradientPosition = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.linear),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );

    _starBounce = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.elasticOut),
    );

    _starRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _tapController.dispose();
    _starController.dispose();
    _sparkleFadeController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    _showSparkles();
    await _tapController.forward();
    await _tapController.reverse();
    widget.onPressed();
  }

  void _showSparkles() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _sparkleFadeController.reset();

    _sparkleOverlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: position.dx - 20,
          top: position.dy - 20,
          width: renderBox.size.width + 40,
          height: renderBox.size.height + 40,
          child: FadeTransition(
            opacity: _sparkleFadeController,
            child: CircularParticle(
              key: UniqueKey(),
              awayRadius: 80,
              numberOfParticles: 25,
              speedOfParticles: 1.5,
              height: renderBox.size.height + 40,
              width: renderBox.size.width + 40,
              onTapAnimation: false,
              particleColor: Colors.white.withAlpha(200),
              awayAnimationDuration: const Duration(milliseconds: 300),
              maxParticleSize: 4,
              isRandSize: true,
              isRandomColor: true,
              randColorList: const [
                Color(0xffD98BA6),
                Color(0xffB56C86),
                Color(0xffF0D4D8),
                Color(0xffA64B6B),
                Color(0xffE7BFC4),
              ],
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: false,
              connectDots: false,
            ),
          ),
        );
      },
    );

    overlay.insert(_sparkleOverlay!);

    _sparkleFadeController.forward();

    Future.delayed(const Duration(milliseconds: 800), () async {
      await _sparkleFadeController.reverse();
      _sparkleOverlay?.remove();
      _sparkleOverlay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) async {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50, amplitude: 128);
        } else {
          HapticFeedback.mediumImpact();
        }
        _tapController.forward();
        _starController.forward(from: 0);
      },
      onTapCancel: () => _tapController.reverse(),
      onTapUp: (_) => _tapController.reverse(),
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge(
            [_gradientController, _tapController, _starController]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: widget.height,
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: const [
                    Color(0xffC94C77),
                    Color(0xffB44568),
                    Color(0xff9E3A5B),
                    Color(0xff7A2E45),
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                  begin: Alignment(_gradientPosition.value, 0),
                  end: Alignment(_gradientPosition.value + 1, 0),
                  tileMode: TileMode.mirror,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Appcolor.berry.withValues(alpha: 0.8),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, _starBounce.value),
                    child: Transform.rotate(
                      angle: _starRotation.value * 2 * 3.1416,
                      child: const Icon(Icons.star_rounded,
                          color: Colors.white, size: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Add Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
