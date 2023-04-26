import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gear_moto_ride_app/models/gear_moto_ride_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Motorcycle> motorcycle;

  const CardSwiper({Key? key, required this.motorcycle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (motorcycle.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: motorcycle.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          final moto = motorcycle[index];
          String imgUrl = _updateImageName(moto.imageUrlBackground.asset.ref);
          imgUrl = '${moto.imageUrlBackground.asset.urlPath}$imgUrl';
          moto.motoId = 'swiper-${moto.motoId}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: moto),
            child: Hero(
              tag: moto.motoId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _updateImageName(String input) {
    String sinImage = input.replaceFirst('image-', '');
    String extension = sinImage.substring(sinImage.lastIndexOf('-') + 1);
    String conExtension = sinImage.replaceFirst('-$extension', '.$extension');
    return conExtension;
  }
}
