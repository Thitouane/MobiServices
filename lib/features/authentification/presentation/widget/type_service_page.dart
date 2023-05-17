import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/presentation/bloc/cubit/type_cubit.dart';
import 'package:mobideliv/features/authentification/presentation/bloc/cubit/type_state.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_password_trader.dart';
import 'package:mobideliv/features/client/accueil/data/repository/type_repo.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/type_model.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';


class TypeServicePage extends StatefulWidget {
  Trader trader;
  ServiceModel service;
  TypeServicePage(this.trader, this.service, {Key? key}) : super(key: key);

  @override
  TypeServicePageState createState() => TypeServicePageState(trader:trader,service:service);
}

class TypeServicePageState extends State<TypeServicePage> {
  late TextEditingController controller;
  TypeServicePageState({required this.trader,required this.service});
  String name = "";
  late Trader trader;
  late ServiceModel service;
  late String type;
  late List<TypeModel> list = [];
  late TypeModel typemodel = TypeModel(service: "");
  late int ind = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildClient(context);
  }

  Widget buildClient(BuildContext context){
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    BlocProvider.of<TypeCubit>(context).fetch();
    return Scaffold(
      body:Form (
        child:ListView(
          children:  [
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column (
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 30,
                      ),
                      child : Image(image: AssetImage('assets/mobideliv.png')),
                    ),
                    Text(
                      "Choix du type de service :",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    Center(
                      child: BlocBuilder<TypeCubit, TypeState>(
                        builder: (context, state) {
                          if (state is TypeLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is TypeError) {
                            return Text(state.message);
                          } else if (state is TypeLoaded) {
                            final TypeList = state.TypeData;
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                itemCount: TypeList.length,
                                itemBuilder: (context, index) {
                                  final TypeModel Type = TypeList[index];
                                  return RadioListTile<int>(
                                    value: index,
                                    groupValue: ind,
                                    activeColor: Color(0xFF6200EE),
                                    onChanged: (value) {
                                      setState(() {
                                        ind = index;
                                        list =TypeList;
                                      });
                                    },
                                    title: Text(Type.service),
                                  );
                                }
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Ajouter un type de service"),
                      onPressed: () async {
                        final name = await openDialog();
                        if ( name ==null|| name.isEmpty) return;
                        setState(() {
                          this.name = name;
                        });
                      },
                    ),
                  ],
                ),
                ],
          ),
        ],
      ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: showFab? FloatingActionButton.extended(
        label: Text(
          "Valider",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onPressed:  () {
          continueToPassword(context);
        },
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<String?> openDialog() =>showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Entrer le nom du service"),
        content: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
              hintText: "Entrer le nom",
          ),
        ),
        actions:[
          TextButton(
              onPressed: submit,
              child: Text('Valider'))
        ]
      ),
  );

  void submit(){
    addType(controller.text);
    AutoRouter.of(context).pop(controller.text);
  }

  Future<void> addType(String text) async{
    TypeModel type = TypeModel(
        service: "");
    type.setService(text);
    await TypeRepository().addtype(type);
  }


  void continueToPassword(context,){
    TypeModel type = TypeModel(
        service: "",);
    trader.setType(list[ind].service);
    service.setType(list[ind].service);
    AutoRouter.of(context).push(
      PasswordTraderRoute(
          trader: trader,
          service: service,
      )
    );
  }
}


