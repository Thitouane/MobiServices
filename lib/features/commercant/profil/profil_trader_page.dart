
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobideliv/core/presentation/popup_prompt.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_trader_cubit.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_trader_state.dart';
import 'package:mobideliv/features/commercant/profil/data/data_sources/firestore_trader_info.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/widget/profil_trader_bar_widget.dart';
import 'package:mobideliv/features/commercant/profil/widget/profil_trader_text_widget.dart';
import '../../../core/presentation/commercant/navbar.dart';
import '../../authentification/presentation/data/data_sources/auth_repository.dart';



class ProfilTraderPage extends StatefulWidget {
  bool edit = false;
  String choice = "trader";
  ProfilTraderPage(this.edit, this.choice, {Key? key}) : super(key: key);

  @override
  ProfilTraderPageState createState() => ProfilTraderPageState(this.edit,this.choice);
}

class ProfilTraderPageState extends State<ProfilTraderPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String imagePath;
  late Trader currentTrader ;
  String choice;
  List<ProfilTraderTextWidget> li= [];
  late String id;

  @override
  void initState() {
    super.initState();
  }
  bool editable = false;
  ProfilTraderPageState(this.editable,this.choice);

  Future<void> getData() async{
    await BlocProvider.of<ProfilTraderCubit>(context).getTraderInfoUseCase.call(paramsOne: transform(), paramsTwo: true);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilTraderCubit>(context).fetch();
    final color = Theme
        .of(context)
        .colorScheme
        .primary;
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
        appBar: ProfilTraderBar(scaffoldKey: _scaffoldKey,),
      body: BlocBuilder<ProfilTraderCubit, ProfilTraderState>(
        builder: (context, state) {
          if (state is ProfilTraderLoading) {
            return const CircularProgressIndicator();
          } else if (state is ProfilTraderError) {
            return Text(state.message);
          } else if (state is ProfilTraderLoaded) {
            imagePath = state.trader.getImage();
            return buildBodyTrader(context, state, editable);
          }
          else {
            return Text(state.toString());
          }
        },
      ),
    );
  }

  ListView buildBodyTrader(context,state,bool editable) {
    ProfilTraderTextWidget text1 = ProfilTraderTextWidget(label:"Numéro de téléphone du commerçant",
      text: state.trader.phonenumber,
      content: (name){},
      editable: this.editable,
      lines: 1,
    );
    ProfilTraderTextWidget text2 = ProfilTraderTextWidget(label:"Nom du commerçant",
      text: state.trader.name,
      content: (name){},
      editable: this.editable,
      lines: 1,
    );
    ProfilTraderTextWidget text3 = ProfilTraderTextWidget(label:"Prénom du commerçant",
      text: state.trader.firstname,
      content: (name){},
      editable: this.editable,
      lines: 1,
    );
    ProfilTraderTextWidget text4 = ProfilTraderTextWidget(label:"Siret",
      text: state.trader.siret,
      content: (name){},
      editable: this.editable,
      lines: 1,
    );
    ProfilTraderTextWidget text5 = ProfilTraderTextWidget(label:"Email",
      text: state.trader.email,
      content: (name){},
      editable: this.editable,
      lines: 1,
    );
    ProfilTraderTextWidget text6 = ProfilTraderTextWidget(label: "info",
      text: state.trader.info,
      content: (name){},
      editable: this.editable,
      lines: 6
    );
    li.add(text1);
    li.add(text2);
    li.add(text3);
    li.add(text4);
    li.add(text5);
    li.add(text6);
    Widget modif = this.createWidgetModifTrader(context, state);
    currentTrader = state.trader;
    if (editable == true){
      return ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildSubMenu(context, state),
          buildImageProfil(context,state),
          text2,
          text3,
          text1,
          text4,
          text5,
          text6,
          modif,
        ],
      );
    }
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        buildSubMenu(context, state),
        buildImageProfil(context,state),
        text2,
        text3,
        text1,
        text4,
        text5,
        text6,
      ],
    );
  }

  Widget buildSubMenu(context,state){
    return DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
        child: Column( children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            child: TabBar(
              onTap: (value){
                if (value == 1) {
                  AutoRouter.of(context).push(
                      ProfilServiceRoute(choice: state.trader.id, idService: state.trader.service,formKey: _scaffoldKey)
                  );
                }
                },
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: [
                const Tab(
                    text: "Infos du commerçant",
                  ),
                GestureDetector(

                  child:const Tab(
                    text: "Infos de l'entrerpise",
                  ),
                ),
              ],
            ),
          ),

        ])
    );
  }

  Widget createWidgetModifTrader(context, state)  {
    return TextButton(
      onPressed: () => showPopup(
        context,
        confirmText: "Confirmer",
        onConfirm: () async {
          Trader use = state.trader;
          use.setPhoneNumber(li[0].text);
          use.setName(li[1].text);
          use.setFirstName(li[2].text);
          use.setSiret(li[3].text);
          use.setEmail(li[4].text);
          use.setInfo(li[5].text);
          use.setId(transform());
          String id = await FirestoreAuth().getCurrentUserId() ?? "";
          await FirestoreTrader.updateTrader(id, use);
          BlocProvider.of<ProfilTraderCubit>(context).updateTraderInfo(transform(), state.trader);
          AutoRouter.of(context).push(
            ProfilTraderRoute(
                edit: false,
                choice: "trader"
            )
          );
        },
        cancelText: "Annuler",
        onCancel: () => AutoRouter.of(context).pop(),
        contentWidget: const Text(
            'Confirmez-vous votre modification ?',
            style: TextStyle(
                color: Palette.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            textAlign: TextAlign.center),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const Text(
        "Valider",
        style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w500),
      ),
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
        onTap: (){uploadImage(state);},
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Image.network(
              state.trader.img,
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

  Future<String> getUserId() async{
    var id = await FirestoreAuth().getCurrentUserId();
    return id!=null ? id: "";
  }

  String transform(){
    String idea = "";
    getUserId().then((String value) => setState(() {
      idea = value;
    }));
    return idea;
  }
}
