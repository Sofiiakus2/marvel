# marvel Superhero mission control

## Core Functionality Implementation:

 - Authentication (Firebase Authentication):
Firebase Authentication will be used to implement superhero login functionality.
Users will be able to log in as predefined superheroes (Iron Man, Spiderman, etc.).

 - Mission Management (Firebase Firestore):
Firebase Firestore will be used as the database for storing and managing mission data.
Mission data will include: Mission Name, Threat Level (enum: Low, Medium, High, World-Ending), Status (enum: Ongoing, Completed).
CRUD operations (create, read, update, delete) for missions will be implemented using Firestore's API.
Data modeled by using dart classes, and converted to and from firestore documents.

 - Superhero Energy Meter (Cubit, Custom Painter):
A Cubit will manage the superhero's fatigue level (progress bar).
Progress will be calculated based on defined coefficients based on the difficulty of completed missions.
A custom painter will be used to render the progress bar in a visually appealing way.

 - Avengers Emergency Alert (Awesome Notifications, Cubit):
A Cubit will monitor the number of pending missions.
If a predefined threshold is exceeded, Awesome Notifications will be used to trigger a local notification: "Nick Fury is calling!".
This will provide the user with an emergency alert.

## Architecture:

 - Modularity: The project exhibits a modular structure, where each feature or module is encapsulated within distinct folders.
 - State Management: Cubit is utilized for state management, promoting predictability and simplifying testing.
