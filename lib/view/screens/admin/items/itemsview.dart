import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/admin/items/viewitemscontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';

class AdminItemsView extends StatelessWidget {
  const AdminItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    ViewItemsControllerImp controller = Get.put(ViewItemsControllerImp());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.goToAddItem();
          },
          backgroundColor: Appcolor.berry,
          elevation: 4,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            // Search Bar

            GetBuilder<ViewItemsControllerImp>(
              builder: (controller) => _buildSearchBar(controller),
            ),
            // Filter and Sort Row
            GetBuilder<ViewItemsControllerImp>(
              builder: (controller) => _buildFilterSortRow(controller),
            ),
            // Products Grid
            _buildProductsGrid(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ViewItemsControllerImp controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(Icons.search, color: Appcolor.berry),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Appcolor.berry.withOpacity(0.5), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(fontSize: 14),
          onChanged: (value) => controller.searchItems(value),
        ),
      ),
    );
  }

  Widget _buildFilterSortRow(ViewItemsControllerImp controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Filter Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt_outlined,
                      size: 18, color: Appcolor.berry),
                  const SizedBox(width: 4),
                  _buildFilterDropdown(controller),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Sort Dropdown
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.sort, size: 18, color: Appcolor.berry),
                  const SizedBox(width: 4),
                  _buildSortDropdown(controller),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Active Status Chip
            _buildFilterChip(
              label: 'Active',
              icon: Icons.check_circle_outline,
              selected: controller.currentFilter == 'active',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'active' : 'all'),
            ),
            const SizedBox(width: 8),
            // Discounted Chip
            _buildFilterChip(
              label: 'Discounted',
              icon: Icons.local_offer_outlined,
              selected: controller.currentFilter == 'discounted',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'discounted' : 'all'),
            ),
            const SizedBox(width: 8),
            // Low Stock Chip
            _buildFilterChip(
              label: 'Low Stock',
              icon: Icons.warning_amber_rounded,
              selected: controller.currentFilter == 'low_stock',
              onSelected: (selected) =>
                  controller.filterItems(selected ? 'low_stock' : 'all'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(ViewItemsControllerImp controller) {
    return DropdownButton<String>(
      value: controller.currentFilter,
      icon: const Icon(Icons.arrow_drop_down, size: 20, color: Appcolor.berry),
      underline: Container(),
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Items')),
        DropdownMenuItem(value: 'active', child: Text('Active')),
        DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
        DropdownMenuItem(value: 'discounted', child: Text('Discounted')),
        DropdownMenuItem(value: 'low_stock', child: Text('Low Stock')),
      ],
      onChanged: (value) {
        if (value != null) {
          controller.filterItems(value);
        }
      },
    );
  }

  Widget _buildSortDropdown(ViewItemsControllerImp controller) {
    return DropdownButton<String>(
      value: controller.currentSort,
      icon: const Icon(Icons.arrow_drop_down, size: 20, color: Appcolor.berry),
      underline: Container(),
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      items: const [
        DropdownMenuItem(value: 'name_asc', child: Text('Name (A-Z)')),
        DropdownMenuItem(value: 'name_desc', child: Text('Name (Z-A)')),
        DropdownMenuItem(value: 'price_asc', child: Text('Price (Low-High)')),
        DropdownMenuItem(value: 'price_desc', child: Text('Price (High-Low)')),
        DropdownMenuItem(value: 'stock_asc', child: Text('Stock (Low-High)')),
        DropdownMenuItem(value: 'stock_desc', child: Text('Stock (High-Low)')),
        DropdownMenuItem(value: 'rating_asc', child: Text('Rating (Low-High)')),
        DropdownMenuItem(
            value: 'rating_desc', child: Text('Rating (High-Low)')),
      ],
      onChanged: (value) {
        if (value != null) {
          controller.sortItems(value);
        }
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Row(
        children: [
          Icon(icon,
              size: 16, color: selected ? Appcolor.berry : Colors.grey[600]),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.grey[50],
      selectedColor: Appcolor.berry.withOpacity(0.1),
      checkmarkColor: Appcolor.berry,
      labelStyle: TextStyle(
        fontSize: 13,
        color: selected ? Appcolor.berry : Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? Appcolor.berry.withOpacity(0.3) : Colors.grey[300]!,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

Widget _buildProductsGrid(ViewItemsControllerImp controller) {
  return GetBuilder<ViewItemsControllerImp>(
    builder: (controller) {
      if (controller.statusRequest == StatusRequest.loding) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.filteredItems.isEmpty) {
        return const Center(child: Text('No products found'));
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.filteredItems.length,
          itemBuilder: (context, index) => ProductCard(
            item: controller.filteredItems[index],
            onEdit: () {
              controller.goToEditItem(controller.filteredItems[index]);
            },
            onDelete: () {
              controller.showDeleteDialog(
                controller.filteredItems[index].itemName ?? 'Product',
                () {
                  controller.deleteItem(
                    controller.filteredItems[index].itemId.toString(),
                    controller.filteredItems[index].itemImg!,
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}

class ProductCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showProductDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Status Badge
            Stack(
              children: [
                Hero(
                  tag: 'product-${item.itemId}',
                  child: CachedNetworkImage(
                    imageUrl: AppLink.itemimage + item.itemImg!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[100],
                      height: 140,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[100],
                      height: 140,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.grey),
                          SizedBox(height: 4),
                          Text('Image not available',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.itemActive == 1 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item.itemActive == 1 ? 'ACTIVE' : 'INACTIVE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    item.itemName ?? 'No Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Category
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Appcolor.berry.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.categoryName ?? 'No Category',
                      style: TextStyle(
                        fontSize: 10,
                        color: Appcolor.berry,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Price Information
                  Row(
                    children: [
                      Text(
                        '\$${item.itemFinalPrice ?? '0.00'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Appcolor.berry,
                        ),
                      ),
                      if (item.itemDiscount != null && item.itemDiscount! > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            '\$${item.itemPrice ?? '0.00'}',
                            style: const TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      const Spacer(),
                      if (item.itemDiscount != null && item.itemDiscount! > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${item.itemDiscount}% OFF',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Stock and Rating
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.inventory_2_outlined,
                        value: '${item.itemCount ?? 0}',
                        label: 'Stock',
                      ),
                      const Spacer(),
                      _buildInfoChip(
                        icon: Icons.star,
                        value:
                            double.parse(item.itemAvgRating).toStringAsFixed(1),
                        label: 'Rating',
                        iconColor: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.edit_outlined,
                      label: 'Edit',
                      color: Colors.blue,
                      onPressed: onEdit,
                    ),
                    _buildActionButton(
                      icon: Icons.delete_outline,
                      label: 'Delete',
                      color: Colors.red,
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: iconColor ?? Colors.grey),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          initialChildSize: 0.7,
          builder: (context, scrollController) => CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.grey[100],
                expandedHeight: 240,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product-${item.itemId}',
                    child: CachedNetworkImage(
                      imageUrl: AppLink.itemimage + item.itemImg!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[100],
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[100],
                        child: const Center(
                          child: Icon(Icons.error, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title and Status
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.itemName ?? 'No Name',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: item.itemActive == 1
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.itemActive == 1 ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: item.itemActive == 1
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Category
                      Text(
                        item.categoryName ?? 'No Category',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price Section
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${item.itemFinalPrice ?? '0.00'}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.berry,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (item.itemDiscount != null &&
                                item.itemDiscount! > 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.itemDiscount}% OFF',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${item.itemPrice ?? '0.00'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Details Section
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDetailItem(
                        icon: Icons.inventory_2_outlined,
                        title: 'Stock',
                        value: '${item.itemCount ?? 0} units',
                      ),
                      _buildDetailItem(
                        icon: Icons.star,
                        title: 'Rating',
                        value:
                            double.parse(item.itemAvgRating).toStringAsFixed(1),
                      ),
                      _buildDetailItem(
                        icon: Icons.category,
                        title: 'Category',
                        value: item.categoryName ?? 'N/A',
                      ),
                      const SizedBox(height: 20),

                      // Descriptions
                      if (item.itemDesc != null && item.itemDesc!.isNotEmpty)
                        _buildDescriptionSection(
                          context,
                          'English Description',
                          item.itemDesc ?? 'N/A',
                        ),
                      if (item.itemDescAr != null &&
                          item.itemDescAr!.isNotEmpty)
                        _buildDescriptionSection(
                          context,
                          'Arabic Description',
                          item.itemDescAr ?? 'N/A',
                        ),
                      if (item.itemDescEs != null &&
                          item.itemDescEs!.isNotEmpty)
                        _buildDescriptionSection(
                          context,
                          'Spanish Description',
                          item.itemDescEs ?? 'N/A',
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(
      BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: TextStyle(
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
