import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StackedSVGImages extends StatefulWidget {
  const StackedSVGImages({super.key});

  @override
  State<StackedSVGImages> createState() => _StackedSVGImagesState();
}

class _StackedSVGImagesState extends State<StackedSVGImages> {
  Color image1Color = const Color.fromRGBO(230, 8, 8, 1);
  Color image2Color = const Color.fromRGBO(0, 255, 0, 1);
  Color image3Color = const Color.fromRGBO(0, 0, 255, 1);
  Color image4Color = const Color.fromARGB(255, 203, 223, 24);

  void _onImageTapped(int imageIndex) {
    setState(() {
      if (imageIndex == 1) {
        image1Color = const Color.fromRGBO(230, 8, 8, 1);
        image2Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image3Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image4Color = const Color.fromRGBO(105, 105, 105, 0.1);
      } else if (imageIndex == 2) {
        image1Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image2Color = const Color.fromRGBO(0, 255, 0, 1);
        image3Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image4Color = const Color.fromRGBO(105, 105, 105, 0.1);
      } else if (imageIndex == 3) {
        image1Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image2Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image3Color = const Color.fromRGBO(0, 0, 255, 1);
        image4Color = const Color.fromRGBO(105, 105, 105, 0.1);
      } else {
        image1Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image2Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image3Color = const Color.fromRGBO(105, 105, 105, 0.1);
        image4Color = const Color.fromARGB(255, 203, 223, 24);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          alignment: Alignment.center,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          constrained: false,
          child: Stack(
            children: [
              const SizedBox(
                height: 2000,
                width: 2000,
              ),
              GestureDetector(
                onTap: () => _onImageTapped(1),
                child: SvgPicture.asset(
                  'assets/routes/Vector 1.svg',
                  color: image1Color,
                ),
              ),
              Positioned(
                left: 240,
                top: 300,
                child: GestureDetector(
                  onTap: () => _onImageTapped(2),
                  child: SvgPicture.asset(
                    'assets/routes/Vector 1 (1).svg',
                    color: image2Color,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                child: GestureDetector(
                  onTap: () => _onImageTapped(3),
                  child: SvgPicture.asset(
                    'assets/routes/Vector 1 (2).svg',
                    color: image3Color,
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 70,
                child: GestureDetector(
                  onTap: () => _onImageTapped(4),
                  child: SvgPicture.asset(
                    'assets/routes/route1.svg',
                    color: image4Color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
