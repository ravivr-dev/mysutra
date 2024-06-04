import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const StarRatingWidget(
      {super.key, required this.rating, required this.onRatingChanged});

  Widget _buildStar(int index) {
    IconData iconData = index < rating ? Icons.star : Icons.star_border;
    return IconButton(
      icon: Icon(iconData),
      color: Colors.yellow[600],
      iconSize: 50,
      onPressed: () {
        onRatingChanged(index + 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
