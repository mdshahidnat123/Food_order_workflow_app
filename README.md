# Food Order Workflow (Flutter) - Assignment

Ye project ek single workflow food-ordering app ka demo hai — **BLoC architecture**, SOLID-friendly structure, error handling, aur unit tests ke sath.  
Deadline ke liye hinglish README diya gaya hai.

## Screenshot
(Insert screenshot in repository after running on device/emulator)

## Kaise chalaye (How to run)
1. Flutter installed hona chahiye (Flutter SDK + Android Studio / VS Code).
2. Repo clone karo ya zip extract karo.
3. Terminal open karke project root par run karo:
```bash
flutter pub get
flutter run
```
4. Unit tests chalane ke liye:
```bash
flutter test
```

## Workflow summary (in Hinglish)
- Home screen par local restaurants list dikhega.
- Kisi restaurant par click karo -> menu screen.
- Menu se items choose karke cart me add karo.
- Checkout pe order place karne ki koshish karoge — fake network call (repository) karega.
- Error handling: agar network error hua to user ko snackbar/alert dikhaya jayega.
- BLoC use hua hai `OrderBloc` to manage cart / checkout states.

## Project structure (short)
- `lib/bloc/` - BLoC files (events, states, bloc)
- `lib/models/` - Restaurant & Menu item models
- `lib/repositories/` - Simulated network layer
- `lib/screens/` - UI screens
- `lib/widgets/` - small reusable widgets
- `test/` - unit tests for bloc

## Notes
- Ye ek demo workflow assignment hai, backend real nahi hai. Repository me fake delay aur random error simulate hota hai to test error handling.
- Aesthetics pe basic care liya gaya — Material design + nice cards.

Good luck — agar aap chaho to main is code ko GitHub repo me push karne ke steps bhi de dunga.
