// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_equipment_view/src/colors.dart';
import 'package:flutter/material.dart';

enum CardViewType { grid, list }

class AnimatedEquipmentCard extends StatelessWidget {
  const AnimatedEquipmentCard({
    super.key,
    required this.equipment,
    required this.index,
    required this.viewType,
    required this.onTap,
    this.avilalblity = false,
    required this.bookingType,
  });

  final dynamic equipment;
  final int index;
  final CardViewType viewType;
  final VoidCallback onTap;
  final bool? avilalblity;
  final String bookingType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          avilalblity == true
              ? onTap
              : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Equipment is not available'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
      child: Builder(
        builder: (context) {
          if (viewType == CardViewType.list) {
            return _buildListViewCard(context);
          } else {
            return _buildGridViewCard(context);
          }
        },
      ),
    );
  }

  Widget _buildListViewCard(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      clipBehavior: Clip.none,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: _buildImage(
              context,
              viewType: viewType,
              height: 120,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildTitle(), _buildPrice()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridViewCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      clipBehavior: Clip.none,
      height: size.height * .2,
      width: size.width * .1,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -55,
            right: 5,
            left: 5,
            child: Container(
              height: 125,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.cardGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${equipment.name}",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            'KWD ',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            bookingType == "half_day"
                                ? '${equipment.halfDayRate}'
                                : '${equipment.fulDayRate}',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' Per Slot',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _buildAvilablityWidget(context),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: -7,
            right: -7,
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildImage(
                viewType: viewType,
                context,
                fit: BoxFit.fill,
                height: 120,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(
    BuildContext context, {
    required double height,
    required CardViewType viewType,
    BoxFit fit = BoxFit.cover,
    required BorderRadius borderRadius,
  }) {
    return Container(
      height: height,
      width: viewType == CardViewType.grid ? 90 : null,
      decoration: BoxDecoration(
        color: AppColors.greyDark,
        borderRadius: borderRadius,
        image: DecorationImage(
          image: NetworkImage(
            'https://www.ibuild.dev6.intersmarthosting.in/storage/${equipment.image}',
          ),
          fit: fit,
        ),
      ),
      child:
          (int.tryParse("${equipment.available}") ?? 0) != 1
              ? Container(
                decoration: BoxDecoration(
                  color: AppColors.greyLight.withValues(alpha: .3),
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'NOT AVAILABLE',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            equipment.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Capacity: ${equipment.capacity} tons',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'KWD ',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: '${equipment.dayRate}',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Per Day',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
