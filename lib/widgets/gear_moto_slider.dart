import 'package:flutter/material.dart';
import 'package:gear_moto_ride_app/models/models.dart';

class GearMotoSlider extends StatefulWidget {
  final List<Motorcycle> motorcycles;
  final String? title;
  final Function onNextPage;

  const GearMotoSlider({
    Key? key,
    required this.motorcycles,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  _GearMotoSliderState createState() => _GearMotoSliderState();
}

class _GearMotoSliderState extends State<GearMotoSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.motorcycles.length,
                itemBuilder: (_, int index) => _MoviePoster(
                    widget.motorcycles[index],
                    '${widget.title}-$index-${widget.motorcycles[index].motoId}')),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Motorcycle motorcycle;
  final String heroId;

  const _MoviePoster(this.motorcycle, this.heroId);

  @override
  Widget build(BuildContext context) {
    motorcycle.motoId = heroId;
    String imgUrl = _updateImageName(motorcycle.imageUrlFrontPage.asset.ref);
    imgUrl = '${motorcycle.imageUrlFrontPage.asset.urlPath}$imgUrl';

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: motorcycle),
            child: Hero(
              tag: motorcycle.motoId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(imgUrl),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            motorcycle.motorcycleName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
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
