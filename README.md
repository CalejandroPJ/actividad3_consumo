# Flutter Marvel App

Ejemplo Flutter para consumir la API de Marvel (developer.marvel.com).

## Requisitos
1. Regístrate en https://developer.marvel.com/
2. Consigue tus `PUBLIC KEY` y `PRIVATE KEY`
3. Edita `lib/models/api_service.dart` y reemplaza:
   ```dart
   static const String _publicKey = 'TU_PUBLIC_KEY';
   static const String _privateKey = 'TU_PRIVATE_KEY';
   ```

## Ejecución
```bash
flutter pub get
flutter run
```

## Notas
- El proyecto incluye búsqueda por nombre (ejemplo: "Spider").
- Usa `http` + `crypto` para generar el hash MD5 (ts+privateKey+publicKey).
