import 'package:flutter/material.dart';
import 'package:gear_moto_ride_app/models/models.dart';
import 'package:gear_moto_ride_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Motorcycle motorcycle =
        ModalRoute.of(context)!.settings.arguments as Motorcycle;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(motorcycle),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(motorcycle),
          _Overview(motorcycle)
          //CastingCards(movie.id)
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Motorcycle motorcycle;

  const _CustomAppBar(this.motorcycle);

  @override
  Widget build(BuildContext context) {
    String imgUrl = _updateImageName(motorcycle.imageUrlFrontPage.asset.ref);
    imgUrl = '${motorcycle.imageUrlFrontPage.asset.urlPath}$imgUrl';

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            motorcycle.motorcycleName,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Motorcycle motorcycle;

  const _PosterAndTitle(this.motorcycle);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    String imgUrl = _updateImageName(motorcycle.imageUrlBackground.asset.ref);
    imgUrl = '${motorcycle.imageUrlBackground.asset.urlPath}$imgUrl';

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: motorcycle.motoId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(imgUrl),
                height: 150,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(motorcycle.motorcycleName,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(motorcycle.year,
                    style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(motorcycle.country, style: textTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Motorcycle motorcycle;

  const _Overview(this.motorcycle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        motorcycle.textDescription,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

String _updateImageName(String input) {
  String sinImage = input.replaceFirst('image-', '');
  String extension = sinImage.substring(sinImage.lastIndexOf('-') + 1);
  String conExtension = sinImage.replaceFirst('-$extension', '.$extension');
  return conExtension;
}
