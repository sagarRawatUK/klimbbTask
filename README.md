# klimbbtask

A task for Klimbb

## Projext Prompt

## The Challenge

Create an app that lets users input location coordinates and tie unique device profiles to these locations. First-time location? Prompt a profile setup. Store these profiles locally and ensure smooth transitions with efficient state management. It's time to show off your Flutter finesse. Good luck!

## Interface

Design a simple interface to
list the saved profiles
display the current device settings
allow for the manual input of latitude and longitude values

## Location Based Profile

Location Input → Implement a feature that allows users to manually input latitude and longitude values. Ensure that the entered values are within the valid range for latitude and longitude.
Profile Creation Prompt → When a new location is entered via the form, the app should prompt the user to create a new device profile. This can be done using Flutter's dialog or notification functionalities.
Device Profile Settings → Implement a device profile model which includes settings like theme color and text size. The user should be able to set these preferences for each profile.

## Data Management

Save and Retrieve Profiles → Implement functionality to save these profiles in local storage and retrieve them when needed. Flutter's shared_preferences package could be useful for this, or consider a local database like SQLite.
State Management → Use a state management solution like Provider, Riverpod, Bloc etc. to handle the application state.

## Edge Cases

Invalid Location Input → Validate the entered latitude and longitude values.
Empty or Duplicate Profiles → Prevent creation of profiles with no changes or identical settings.
Profile Lookup Failures → Manage scenarios where profile lookup fails, defaulting to basic settings.
State Management Errors → Ensure accurate application state during profile transitions.
Data Persistence Issues → Handle potential errors in saving/retrieving profiles from local storage.
UI/UX Consistency → Provide consistent and responsive user feedback across devices and orientations.

## Response

Once the app loads show the home screen.
Show how the application allows users to manually input latitude and longitude values.
Demonstrate the app prompting the user to create a profile when a new location is entered.
Showcase the device profile model with settings like theme color and text size.
Show how these profiles are saved in local storage and retrieved when needed.
Highlight the smooth transition between profiles as users change locations.
Demonstrate how the application handles one or two of the major edge cases.
