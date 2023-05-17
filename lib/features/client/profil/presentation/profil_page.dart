
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/presentation/popup_prompt.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_bar_widget.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_text_widget.dart';
import 'package:mobideliv/features/client/profil/presentation/widgets/profil_widget.dart';
import 'package:mobideliv/core/styles/colors.dart';
import '../../../authentification/presentation/data/data_sources/auth_repository.dart';
import 'bloc/profil_state.dart';
import 'domain/entity/client_entity.dart';
import 'bloc/profil_cubit.dart';

class ProfilPage extends StatefulWidget {
  bool edit = false;
  ProfilPage(this.edit, {Key? key}) : super(key: key);

  @override
  ProfilPageState createState() => ProfilPageState(this.edit);
}

class ProfilPageState extends State<ProfilPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileWidget profil = ProfileWidget(imagePath: "");
  late Client currentUser ;
  List<ProfilTextWidget> li= [];
  bool editable = false;
  ProfilPageState(this.editable);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = "UserPreferences.myUser";
    BlocProvider.of<ProfilUserCubit>(context).fetch();
    final color = Theme
        .of(context)
        .colorScheme
        .primary;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: ProfilBar(scaffoldKey: _scaffoldKey,),
      body:BlocBuilder<ProfilUserCubit, ProfilUserState>(
          builder: (context, state) {
            if (state is ProfilUserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfilUserError) {
              return Text(state.message);
            } else if (state is ProfilUserLoaded) {
              final user = state.user;
              return buildBody(context, state, editable);
            }
            else {
              return Text(state.toString());
            }
          },
        ),
      );
  }


  Future<void> getData() async{
    await BlocProvider.of<ProfilUserCubit>(context).getUserInfoUseCase.call(paramsOne: transform(), paramsTwo: true);
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



  ListView buildBody(context,state,bool editable){
    ProfilTextWidget text1 = ProfilTextWidget(label:"Numéro de tel",text: state.user.phonenumber, content: (name){},editable: this.editable,);
    ProfilTextWidget text2 = ProfilTextWidget(label:"Nom",text: state.user.name, content: (name){},editable: this.editable,);
    ProfilTextWidget text3 = ProfilTextWidget(label:"Prénom",text: state.user.firstname, content: (name){},editable: this.editable,);
    ProfilTextWidget text4 = ProfilTextWidget(label:"Addresse",text: state.user.addresse, content: (name){}, editable: this.editable,);
    ProfilTextWidget text5 = ProfilTextWidget(label:"Email",text: state.user.email, content: (name){}, editable: this.editable,);
    li.add(text1);
    li.add(text2);
    li.add(text3);
    li.add(text4);
    li.add(text5);
    SizedBox box = SizedBox(height: 40,);
    Widget modif = this.createWidgetModif(context, state);
    currentUser = state.user;
    if (editable == true){
      return ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: state.user.img,
          ),
          text1,
          text2,
          text3,
          text4,
          text5,
          modif,
        ],
      );
    }
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: state.user.img,
        ),
        text1,
        text2,
        text3,
        text4,
        text5,
      ],
    );
  }

  Widget createWidgetModif(context, state){
    return TextButton(
      onPressed: () => showPopup(
        context,
        confirmText: "Confirmer",
        onConfirm: () {
          Client use = state.user;
          use.setPhoneNumber(li[0].text);
          use.setName(li[1].text);
          use.setFirstName(li[2].text);
          use.setAddresse(li[3].text);
          use.setEmail(li[4].text);
          BlocProvider.of<ProfilUserCubit>(context).updateUserInfo("", state.user);
          AutoRouter.of(context).push(
            ProfilRoute(
                edit: false
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
}
