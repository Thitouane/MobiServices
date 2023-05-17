# mobiservice
https://mobideliv.wordpress.com/

## Build
```
flutter pub run build_runner build
```

## Run
```
flutter run --no-sound-null-safety
```

## Bug
ça plante dès qu'on fait trop de trucs sur la carte,
double point sur la carte, double ping,
plantage si on change la postion de l'écran: mode paysage, mode portrait
android bug avec intl car utilise browser
solution possible : 
```flutter pub get```

## Fix à faire
Signaler que le mot de passe soit au minimum de taille 6 et qu'avec des caractères normaux,
retire les backwards dans les pages de création de compte.

Ajouter type dans service
optionnel ajouter un bouton pour créer un type

bug type de service (domicile) quand on scroll au chargement de l'app

## Build l'APK
```
flutter build apk --release --no-sound-null-safety
```

