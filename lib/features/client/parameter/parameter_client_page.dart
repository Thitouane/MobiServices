
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';
import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/presentation/popup_prompt.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_bar_widget.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_text_widget.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_widget.dart';
import 'package:mobideliv/core/styles/colors.dart';

class ParameterPage extends StatefulWidget {
  ParameterPage( {Key? key}) : super(key: key);

  @override
  ParameterPageState createState() => ParameterPageState();
}

class ParameterPageState extends State<ParameterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = false;

  ParameterPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .colorScheme
        .primary;
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey,),
        body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Compte :',
              textAlign:  TextAlign.center,
              style:  GoogleFonts.poppins(
                fontSize: 18,
              ),
            ),
            Container(
              // profilvuepardautresutilisateur (748:6724)
              child:
              Text(
                'Mode sombre',
                textAlign:  TextAlign.center,
                style:  GoogleFonts.poppins (
                  fontSize: 18,
                ),
              ),
            ),
            Container(
                child: Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.redAccent,
                )
            ),
          ],
        ),
        )
    );
  }

  void changeTheme() async {
    if (AdaptiveTheme.of(context).isDefault){
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      AdaptiveTheme.of(context).setDark();
      setState(() {
        isSwitched = true;
      });
    }
    else
    {
      AdaptiveTheme.of(context).setLight();
      setState(() {
        isSwitched = false;
      });
    }
  }

}
