import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
        
        Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Image.asset(
          imagePath,
          height: 120,
          width: 170
          
        )
      ),
    );
  }
}