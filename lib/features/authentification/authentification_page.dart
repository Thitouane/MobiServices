import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';

import '../../core/presentation/popup_prompt.dart';
import '../client/profil/presentation/domain/entity/client_entity.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  WelcomePageState();

  late String id = "";
  late String identifiant = "";
  late String mdp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
            child: Image(image: AssetImage('assets/mobideliv.png')),
          ),
          Text(
            "Bienvenue",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 25,
            ),
          ),
          Text(
            "Accéder à votre compte",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ),
            child: TextField(
                decoration: InputDecoration(
                  hintText: "Identifiant",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    identifiant = value;
                  });
                }),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Mot de Passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  mdp = value;
                });
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          GestureDetector(
            onTap: () {
              allCheck(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 5, color: Colors.black),
                color: Colors.black,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Center(
                child: Text(
                  "Connexion",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 30,
            ),
            child: InkWell(
              onTap: () {
                auth(context);
              },
              child: Ink(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.person), // <-- Use 'Image.asset(...)' here
                      SizedBox(width: 12),
                      Text(
                        "Connecter-vous en tant qu'inviter",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              'Vous n\'avez pas de compte ?',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: popupButtonFormulaire(context),
          ),
        ],
      ),
    );
  }

  Widget popupButtonFormulaire(BuildContext context) {
    return InkWell(
      onTap: () => showPopup(
        context,
        confirmText: "Client",
        onConfirm: () {
          AutoRouter.of(context).push(LoginRoute(
            type: "client",
          ));
        },
        cancelText: "Commerçant",
        onCancel: () {
          AutoRouter.of(context).push(LoginRoute(
            type: "",
          ));
        },
        contentWidget: const Text('Quel type de compte souhaitez-vous créer ?',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 20),
            textAlign: TextAlign.center),
      ),
      child: Ink(
        child: Text(
          'Inscrivez-vous',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.lightBlueAccent,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void auth(context) async {
    await anonymousCredential();
    // context.router.push(ProfilRoute(edit: false));
    AutoRouter.of(context).push(HomePageRoute());
  }

  Future getUserId() async {
    var nom = await FirestoreAuth().getCurrentUserId();
    id = (await FirestoreAuth().getCurrentUserId())!;
    return "";
  }

  Future<String> getAnonymousImageUrl() async{
    Reference ref = FirebaseStorage.instance
        .ref('anonyme.png');
    return await ref.getDownloadURL();
  }

  Future<String> anonymousCredential() async {
    Client? client = await FirestoreAuth().authAnonymous();
    await FirestoreAuth().addClient(client!).then((value) => getUserId());
    return "lol";
  }

  Future<String> checkauth() async{
    var uid = await FirestoreAuth().authentification(identifiant, mdp);
    print("uid  = "+uid);
    setState(() {
      this.id = uid;
    });
    return "";
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? messageError(){
    print("coucou");
    if(id == "erreur"){
      print("scaffold");
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Identifiant incorrect"),
      ));
    }
    print("hloo");
    return null;
  }
  void allCheck(context) async {
    await checkauth();
    await messageError();
    await authentification(context);
  }


  Future<String> authentification(context) async {
    var uid = this.id;
    var type = await FirestoreAuth().getTypeOfAccount(uid);
    if (type == "client") {
      AutoRouter.of(context).push(
          HomePageRoute()
      );
    } else if (type == "trader") {
      // context.router.push(
      // );
      AutoRouter.of(context).push(
          HomeCommercantRoute(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Identifiant incorrect"),
      ));
    }
    return "";
  }
}
