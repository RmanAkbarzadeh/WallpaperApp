import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/res/wallpaper_colors.dart';

import '../../data/model/wallpaper_model.dart';

class WallpaperDetailPage extends StatelessWidget {
  final Datum modelData;

  const WallpaperDetailPage(this.modelData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildTopPageImage(mq),
            _buildDetailRow(mq, "ID", modelData.id),
            const Divider(thickness: 0.3,color: Colors.white,),
            _buildDetailRow(mq, "Category", modelData.category!.name),
            const Divider(thickness: 0.3,color: Colors.white,),
            _buildDetailRow(mq, "Created At", modelData.createdAt.toString()),
            const Divider(thickness: 0.3,color: Colors.white,),
            _buildDetailRow(mq, "Resolution", modelData.resolution),
            const Divider(thickness: 0.3,color: Colors.white,),
            _buildDetailRow(mq, "Ratio", modelData.ratio),
            const Divider(thickness: 0.3,color: Colors.white,),
            _buildColorDetailRow(context,mq,modelData.colors)
          ],
        ),
      ),
    );
  }

  Widget _buildColorDetailRow(BuildContext context,MediaQueryData mq,List<String> colorsList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          const Text(
            "Colors :",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(width: 15,),
          SizedBox(
            width: mq.size.width/2,
            height: 50,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1,color: Colors.white),
                        color: Color(
                            int.parse("0xff${colorsList[index].substring(1)}"))),
                  );
                },
                separatorBuilder: (context,index){
                return const SizedBox(width: 20,);
                },
                itemCount: colorsList.length),
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(MediaQueryData mq, String title1, String detail1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        children: [
          Text(
            "$title1 : ",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            detail1,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPageImage(MediaQueryData mq) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: mq.size.height * 0.6,
            child: Image.network(
              modelData.thumbs.original,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              child: Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                    color: WallpaperColors.primaryColor.withOpacity(0.5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        modelData.favorites.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      const Expanded(child: SizedBox()),
                      FittedBox(
                        child: Text(
                          modelData.views.toString(),
                          style:
                              const TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
