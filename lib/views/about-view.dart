import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:kinga/res/Ids.dart';
import 'package:kinga/res/strings.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutGameDialog extends StatefulWidget {

  @override
  _AboutGameDialogState createState() => _AboutGameDialogState();
}

class _AboutGameDialogState extends State<AboutGameDialog> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String appVersion;

  String deviceMake;
  String deviceModel;
  String deviceOSVersion;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: Text(
        AppStrings.appName,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new FutureBuilder(
            future: getVersionNumber(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                Text(
                  snapshot.hasData ? snapshot.data : AppStrings.loading,
                ),
          ),

          SizedBox(
            height: 15,
          ),

          Text(
            "Made by ${AppStrings.appAuthor}",
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  heroTag: Ids.feedbackHeroTag,
                  child: const Icon(
                    Icons.feedback,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  onPressed: _sendFeedback,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  heroTag: Ids.shareAppHeroTag,
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                  onPressed: _inviteFriend,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 15.0,
          ),

          Divider(),

          InkWell(
            onTap: _launchDevWebsite,
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
              ),
              title: Text(AppStrings.developerWebsite),
              trailing: Icon(Icons.arrow_right),
            ),
          ),

          Divider(),

          InkWell(
            onTap: () => launch(AppStrings.url_who_covid_donation),
            child: ListTile(
              leading: Icon(
                Icons.monetization_on,
              ),
              title: Text(AppStrings.donateToWho),
              subtitle: Text(AppStrings.donateToWhoSubtitle),
              trailing: Icon(Icons.arrow_right),
            ),
          ),

          Divider(),

          new SizedBox(
            height: 25.0,
          ),

          new Text(
              AppStrings.appLegalese,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              )
          ),
        ],
      ),
    );
  }

  // Launch a mail application to be used to send feedback to the developer
  _sendFeedback() {
    String subject = '${AppStrings.appName} Game Feedback';
    //String body = "\bFeedback:\b  \n\n";

    String body = "\bFeedback:\b  \n\n" +
        "\n\bApp Version:\b $appVersion " +
        "\n\bManufacturer:\b $deviceMake " +
        "\n\bDevice:\b $deviceModel " +
        "\n\bOS Version:\b $deviceOSVersion ";

    if(Platform.isAndroid) {
      _launchURL('mailto:${AppStrings.companyEmail}?subject=$subject&body=$body');
    } else if (Platform.isIOS) {
      _launchURL('mailto:${AppStrings.companyEmail}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    }
  }

  Future<AndroidDeviceInfo> getAndroidDeviceInfo(deviceInfo) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  Future<IosDeviceInfo> getIosInfo(deviceInfo) async {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo;
  }

  Future<void> initPlatformState() async {

    if(Platform.isAndroid) {
      getAndroidDeviceInfo(deviceInfoPlugin).then((androidInfo) {
        deviceMake = androidInfo.manufacturer;
        deviceModel = androidInfo.model;
        deviceOSVersion = androidInfo.version.sdkInt.toString();
      });
    } else if (Platform.isIOS) {
      getIosInfo(deviceInfoPlugin).then((iosInfo) {
        deviceMake = 'Apple';
        deviceModel = iosInfo.utsname.machine;
        deviceOSVersion = iosInfo.utsname.version;
      });
    }
  }

  // Launch an app selection popup to select the app to be used for sharing a link to KINGA
  _inviteFriend() {
    Share.share('Check out the ${AppStrings.appName} Game here: ${AppStrings.appName}');
  }

  // Launch a developer website
  _launchDevWebsite() {
    _launchURL(AppStrings.url_my_website);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version + ' (' + packageInfo.buildNumber + ')';
    appVersion = version;
    return version;
  }
}