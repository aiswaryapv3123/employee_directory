import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({Key key, this.name, this.username, this.image, this.website, this.companyName,this.catchPhrase}) : super(key: key);
  final String name;
  final String username;
  final String image;
  final String website;
  final String companyName;
  final String catchPhrase;

  @override
  _EmployeeDetailsPageState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,

            ),
            child: Row(children: [
              Icon(Icons.format_list_bulleted, color: Colors.teal),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.search, color: Colors.grey))
            ],),),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.09,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
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
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                widget.username,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                widget.name+"'s Website : "+widget.website,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                widget.name+"'s Company Name : "+widget.companyName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                widget.name+"'s catchPhrase : "+widget.catchPhrase,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
            ],
          )
        ),
      ),
    );
  }
}
