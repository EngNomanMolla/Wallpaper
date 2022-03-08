import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class SetWallpaper extends StatefulWidget {
  var image;
  SetWallpaper(this.image);

  @override
  _SetWallpaperState createState() => _SetWallpaperState(image);
}

class _SetWallpaperState extends State<SetWallpaper> {
  var image;
  _SetWallpaperState(this.image);
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            height: _height,
            placeholder: (context, url) =>
                Container(child: CupertinoActivityIndicator()),
          ),
          Positioned(
            top: _height - 80,
            left: _width - 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  child: InkWell(
                      onTap: (){
                        setWallPaper(image);

                      },
                      child: Icon(Icons.wallpaper,color: Colors.white,)),
                  message: "Set Wellpaper",

                ),
                SizedBox(
                  width: 10,
                ),
                Tooltip(
                  child: Icon(Icons.download,color: Colors.white,),
                  message: "Download",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void setWallPaper(image)async {

    int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
    var file=await DefaultCacheManager().getSingleFile(image);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location).then((value) {
      return showToast();
    }); //provide image path
  }
  showToast(){
   // Fluttertoast.showToast(msg: "Wallpaper set sucessfully");
  }
}
