import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EmployeeTile extends StatefulWidget {
  const EmployeeTile({Key key, this.name, this.userName, this.onPressed, this.image}) : super(key: key);
  final String name;
  final String userName;
  final String image;
  final Function onPressed;

  @override
  _EmployeeTileState createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical:MediaQuery.of(context).size.height * 0.02,
        ),
          decoration:BoxDecoration(
              color: Colors.red,
              borderRadius:BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 3,
                offset: Offset(-4, -2),
                // color: Color.fromRGBO(255, 255, 255, 0.9),
                color: Color.fromRGBO(0, 0, 0, 0.15),
              ),
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 3,
                offset: Offset(4, 2),
                color: Color.fromRGBO(255, 255, 255, 0.9),
                // color: Color.fromRGBO(0, 0, 0, 0.15),
              ),
            ],
          ),
        child: Row(
          children: [
            CachedNetworkImage(
              width: MediaQuery.of(context).size.width * 0.09,
              height: MediaQuery.of(context).size.width * 0.09,
              imageUrl: widget.image == null ? "https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png" : widget.image,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => Center(
                heightFactor: 1,
                widthFactor: 1,
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 2,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    border:
                    Border.all(color: Colors.white, width: 2.0),

                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
      //       Container(
      //         width: MediaQuery.of(context).size.width * 0.07,
      //         height: MediaQuery.of(context).size.width * 0.07,
      //         decoration:BoxDecoration(
      //     color: Colors.red,
      //     shape:BoxShape.circle
      // ),),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                Text(widget.userName,style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
