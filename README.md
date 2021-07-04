# OnlineFoodApp-Flutter

This is Online Food order Application using Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Branching Strategy

# feature

For new features, form branch name with the combination of "feature/OnlineFoodApp" keyword and task title.
Ex: (feature/OnlineFoodApp-design-changes)


## StateManagement

   We are going to use Provider based statemanagement. 
   Kindly check, https://pub.dev/packages/provider

## Things need to check before creating PR:

1. Need to analysis the code using pedantic analysis and fix the issue
2. Dart Analysis warnings should be empty
3. Common code need to move as a widget and re-use it wherever needed
4. Test previous page and current page navigation flow
5. Test App minimize flow on current page

## Things need to care while developing
1. Add Lazy loaders for the api fetching pages
2. handle Api failure case and  empty flow case
3. Handle Progress Bar lifecycle.
4. Add animation if requires





