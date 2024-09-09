![Logo](workout.png)
# :sparkles::sparkles: Manican Beauty Center




# manican
Developers documentation contains setup processes and rules to work in the project.

### Generate Easy localization files:

```bash
dart run easy_localization:generate --source-dir ./assets/i18n/;dart run easy_localization:generate --source-dir ./assets/i18n -f keys -o locale_keys.g.dart
```

## Notice!!

* If this the first time you run the project make sure you get the `pubspec.yaml` dependency and sync the gradle project
* You do this through the following steps:

  1. turn on your vpn
  2. open android studio and run
     ```bash
     flutter pub get
     ```
  3. on your project and go to the file `/android/build.gradle`
  4. you notice that in the top right side there is a button said `Open for Editing in Android Studio`
  5. press on that button then select `New Window`
  6. wait until the gradle sync successfully (you can see the progress by open the `build` window in the bottom)

  ---
