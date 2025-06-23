import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/home/itemcardcontent.dart';

class ItemCard extends StatefulWidget {
  final ItemsModel itemsModel;
  final Function() onTap;
  final int colorIndex;

  const ItemCard({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.colorIndex,
  });

  @override
  State<ItemCard> createState() => _EnhancedItemCardState();
}

class _EnhancedItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get discountPercentage {
    final originalPrice =
        double.tryParse((widget.itemsModel.itemPrice ?? '0').toString()) ?? 0;
    final finalPrice =
        double.tryParse((widget.itemsModel.itemFinalPrice ?? '0').toString()) ??
            0;
    if (originalPrice > 0) {
      return ((originalPrice - finalPrice) / originalPrice) * 100;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _animationController.reverse(),
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _animationController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _animationController.reverse();
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:    Get.find<HomeControllerImp>(). gradientColors[widget.colorIndex]
                          .withValues(alpha: 0.3),
                      spreadRadius: 0,
                      blurRadius: _isHovered ? 25 : 15,
                      offset: Offset(0, _isHovered ? 15 : 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ItemCardContent(
                    itemsModel: widget.itemsModel,
                    colorIndex: widget.colorIndex,
                    discountPercentage: discountPercentage,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

