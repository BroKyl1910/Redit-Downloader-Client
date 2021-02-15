import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reddit_downloader_client/blocs/video_download_bloc.dart';
import 'package:reddit_downloader_client/blocs/video_information_bloc.dart';
import 'package:reddit_downloader_client/json_models/video_information_model.dart';
import 'package:reddit_downloader_client/widgets/custom_combo_box.dart';
import 'package:reddit_downloader_client/widgets/custom_flat_text_field.dart';
import 'package:reddit_downloader_client/widgets/custom_raised_button.dart';

class DownloadScreen extends StatefulWidget {
  final String url;

  DownloadScreen({this.url});

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int selectedResolution;

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

  void getVideoInformation(BuildContext context, String url) {
    var bloc = Provider.of<VideoInformationBloc>(context, listen: false);
    bloc.getVideoInformation(url);
  }

  void _handleQualityChange(String value) {
    int res = int.parse(value.substring(0, value.length - 1));
    selectedResolution = res;
  }

  void _handleDownloadClick(
      BuildContext context, VideoInformationModel videoInformationModel) {
    String baseUrl = videoInformationModel.BaseDownloadUrl;
    int quality = selectedResolution;

    var bloc = Provider.of<VideoDownloadBloc>(context, listen: false);
    bloc.downloadVideo(baseUrl, quality);
  }

  Widget _buildQualityCombobox(
      BuildContext context, List<int> availableResolutions) {
    List<String> resStrings = new List<String>();
    for (int i = availableResolutions.length - 1; i >= 0; i--) {
      resStrings.add(availableResolutions[i].toString() + "p");
    }
    selectedResolution =
        int.parse(resStrings[0].substring(0, resStrings[0].length - 1));
    return CustomComboBox(values: resStrings, onChange: _handleQualityChange);
  }

  Widget _buildInfoBlock(
      BuildContext context, VideoInformationModel videoInformationModel) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 64,
                          child: Text(
                            videoInformationModel.Title,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(40, 0, 0, 0),
                                          offset: Offset(2, 2),
                                          blurRadius: 4,
                                          spreadRadius: 4)
                                    ]),
                                child: CircleAvatar(
                                  radius: 95,
                                  backgroundImage: NetworkImage(
                                      videoInformationModel.ThumbnailUrl),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'Quality: ',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  _buildQualityCombobox(
                                      context,
                                      videoInformationModel
                                          .AvailableResolutions),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<bool>(
                            stream: Provider.of<VideoDownloadBloc>(context,
                                    listen: false)
                                .isDownloading,
                            initialData: false,
                            builder: (context, snapshot) {
                              if (snapshot.data == false) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width - 64,
                                  child: CustomRaisedButton(
                                    text: "Download",
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    onTap: () => _handleDownloadClick(
                                        context, videoInformationModel),
                                  ),
                                );
                              } else {
                                return _buildCircularProgressIndicator(context,
                                    MediaQuery.of(context).size.width - 64);
                              }
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgressIndicator(BuildContext context, double width) {
    return Container(
      width: width,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 2),
              ],
              borderRadius: BorderRadius.circular(50)),
          height: 50,
          width: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getVideoInformation(context, widget.url);

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
                StreamBuilder<VideoInformationModel>(
                  stream:
                      Provider.of<VideoInformationBloc>(context, listen: false)
                          .videoInformation,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildInfoBlock(context, snapshot.data);
                    }
                    return _buildCircularProgressIndicator(
                        context, MediaQuery.of(context).size.width);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
