
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_trader_cubit.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/profil_trader_page.dart';
import 'package:mobideliv/features/commercant/profil/widget/profil_trader_bar_widget.dart';
import 'package:mobideliv/features/commercant/profil/widget/profil_trader_text_widget.dart';

import '../../../../core/presentation/client/navbar.dart';
import '../bloc/profil_service_at_home_cubit.dart';
import '../bloc/profil_service_at_home_state.dart';

class ProfilServicePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> formKey;
  String choice = "trader";
  String idService;
  ProfilServicePage(this.choice,this.idService, {Key? key, required this.formKey}) : super(key: key);

  @override
  ProfilServicePageState createState() => ProfilServicePageState(this.choice,this.idService);
}

class ProfilServicePageState extends State<ProfilServicePage> {

  late String imagePath;
  late Trader currentTrader ;
  String idservice;
  String choice;
  List<ProfilTraderTextWidget> li= [];

  @override
  void initState() {
    super.initState();
  }
  ProfilServicePageState(this.choice,this.idservice);

  Future<void> getData() async{
    await BlocProvider.of<ProfilServiceCubit>(context).service;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilServiceCubit>(context).fetch(idservice);
    return Scaffold(
        key: widget.formKey,
        drawer: NavBar(),
        appBar: ProfilTraderBar(scaffoldKey: widget.formKey),
    body: BlocBuilder<ProfilServiceCubit, ProfilServiceState>(
        builder: (context, state) {
          if (state is ProfilServiceLoading) {
            return const CircularProgressIndicator();
          } else if (state is ProfilServiceError) {
            return Text(state.message);
          } else if (state is ProfilServiceLoaded) {
            return Scaffold(

              body: buildBodyService(context, state,false),
            );
          }
          else {
            return Text(state.toString());
          }
        },
      ),
    );
  }

  ListView buildBodyService(context,state,bool editable){
    ProfilTraderTextWidget text1 = ProfilTraderTextWidget(label:"Nom",
      text: state.service.name,
      content: (name){},
      editable: editable,
      lines: 1,
    );
    ProfilTraderTextWidget text2 = ProfilTraderTextWidget(label:"Adresse email",
      text: state.service.mail,
      content: (name){},
      editable: editable,
      lines: 1,
    );
    ProfilTraderTextWidget text3 = ProfilTraderTextWidget(label:"Ville",
      text: state.service.ville,
      content: (name){},
      editable: editable,
      lines: 1,
    );
    ProfilTraderTextWidget text4 = ProfilTraderTextWidget(label:"Horraire",
      text: state.service.horraire,
      content: (name){},
      editable: editable,
      lines: 1,
    );
    ProfilTraderTextWidget text5 = ProfilTraderTextWidget(label:"Téléphone",
      text: state.service.tel,
      content: (name){},
      editable: editable,
      lines: 1,
    );
    ProfilTraderTextWidget text6 = ProfilTraderTextWidget(label: "Info",
        text: state.service.info,
        content: (name){},
        editable: editable,
        lines: 6
    );
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        buildSubMenu(context, state),
        buildImageProfil(context,state),
        text1,
        text2,
        text3,
        text4,
        text5,
        text6,
      ],
    );
  }

  Widget buildSubMenu(context,state){
    return DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 1,
        child: Column( children: <Widget>[
          Container(
            child: TabBar(
              onTap: (value){
                if (value == 0) {
                  onTap: (){
                    AutoRouter.of(context).pop();
                  };
                }
              },
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                GestureDetector(
                  onTap: (){
                    AutoRouter.of(context).push(
                      ProfilTraderRoute(edit: false, choice: choice)
                    );
                  },
                  child:Tab(
                    text: "Infos du commerçant",
                  ),
                ),
                Tab(text: "Infos de L'entreprise"),
              ],
            ),
            margin: EdgeInsets.only(
              bottom: 15,
            ),
          ),

        ])
    );
  }

  Widget buildImageProfil(BuildContext context,state) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(state),
        ],
      ),
    );
  }



  Widget buildImage(state) {
    return GestureDetector(
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Image.asset(
            state.service.img,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );



  void uploadImage(state) async{
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,);
    Reference ref = FirebaseStorage.instance
        .ref().child(state.trader.getId()+image!.path);
    var task = await ref.putFile(File(image.path));
    Trader use = state.trader;
    await task.ref.getDownloadURL().then((value) async {
      use.setImage(value);
      state.trader.img = value;
    });
    await BlocProvider.of<ProfilTraderCubit>(context).modifyTraderInfoUseCase(paramsOne:use ,paramsTwo:true );
    setState(() {

    });


  }
}
