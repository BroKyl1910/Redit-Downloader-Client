import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit_downloader_client/helpers/color_palette.dart';
import 'package:reddit_downloader_client/widgets/custom_flat_text_field.dart';
import 'package:reddit_downloader_client/widgets/custom_raised_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildTopBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 3),
                      color: Color.fromARGB(50, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 3)
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.reddit,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Download",
                    style: GoogleFonts.montserrat(
                        fontSize: 24, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      offset: Offset(4, 4),
                      blurRadius: 2,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: CustomFlatTextField(
                        hintText: 'Paste URL from Reddit here...',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: CustomRaisedButton(
                      text: "Download",
                      color: Colors.red,
                      textColor: Colors.white,
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndeterminateProgressBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                SizedBox(
                  height: 50,
                ),
                _buildForm(),
                SizedBox(
                  height: 20,
                ),
                _buildIndeterminateProgressBar()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
