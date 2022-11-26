<div align="center">
  <!-- <img src="/Anseo Transit\journey_planner\assets\logo\my_logo_invert1.png" alt="logo" width="auto" height="auto" /> -->
  <h1>Anseo Admin</h1>
  <div style="background-color:#f0f0f0"><img src="/Anseo Admin\anseo_admin\assets\logo\logo1_invert.png" alt="Anseo Admin Logo" width="auto" height="auto" /></div>
</div>

---

<div align="center">
  <h4>
    <a href="../Video Demonstration">View Demo</a>
    <span> · </span>
    <a href="https://anseo.gitbook.io/anseo-documentation/">Documentation</a>
  </h4>
</div>

---

<!-- Table of Contents -->

# :notebook_with_decorative_cover: Table of Contents

- [Features](#dart-features)
- [Getting Started](#toolbox-getting-started)
- [Screenshots](#iphone-screenshots)

  - [Introduction / Authentication](#one-introduction-authentication)
  - [Configure Travel Card Type](#two-configure-travel-card-type)
  - [Add Account](#three-add-account)
  - [Modify Account](#four-modify-account)
  - [Delete Account](#five-delete-account)

- [Directory Structure](#file_folder-directory-structure)
- [System Design](#triangular_ruler-system-design)
  - [Methodology](#traffic_light-methodology)
  - [Three Tier Architecture](#office-three-tier-architecture)
  - [Database](#cd-database)
  - [USE Case](#performing_arts-use-case)
  - [Colour Scheme](#art-colour-scheme)
- [Plugins](#electric_plug-plugins)
- [Development Process](#construction-development-process)

---

<!-- Features -->

## :dart: Features

- [x] Configure an NFC travel card to contain a fare type
- [x] Create a <i><b>User</b> / <b>Driver</b> / <b>Admin</b></i> account
- [x] Modify email, password and personal information of a <i><b>User</b> / <b>Driver</b> / <b>Admin</b></i> account
- [x] Delete a <i><b>User</b> / <b>Driver</b> / <b>Admin</b></i> account

---

<!-- Getting Started -->

## :toolbox: Getting Started

Have a look at the documentation [here](https://anseo.gitbook.io/anseo-documentation/) to get started.

---

<!-- Screenshots -->

## :iphone: Screenshots

<!-- Introduction / Authentication-->

### :one: Introduction / Authentication

|                          Splash Screen                          |                         Landing Page                          |                       Sign In                       |                       Sign Up                       |
| :-------------------------------------------------------------: | :-----------------------------------------------------------: | :-------------------------------------------------: | :-------------------------------------------------: |
| <img src="Screenshots/Splash Screen.jpg" alt="Splash Screen" /> | <img src="Screenshots/Landing Page.jpg" alt="Landing Page" /> | <img src="Screenshots/Sign In.jpg" alt="Sign In" /> | <img src="Screenshots/Sign Up.jpg" alt="Sign Up" /> |

<!-- Configure Travel Card Type -->

### :two: Configure Travel Card Type

|                                 Configure Travel Card 1                                  |                                 Configure Travel Card 2                                  |                                 Configure Travel Card 3                                  |                                 Configure Travel Card 4                                  |
| :--------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------: |
| <img src="Screenshots/Configure Travel Card Type 1.jpg" alt="Configure Travel Card 1" /> | <img src="Screenshots/Configure Travel Card Type 2.jpg" alt="Configure Travel Card 2" /> | <img src="Screenshots/Configure Travel Card Type 3.jpg" alt="Configure Travel Card 3" /> | <img src="Screenshots/Configure Travel Card Type 4.jpg" alt="Configure Travel Card 4" /> |

<!-- Add Account -->

### :three: Add Account

|                         Admin Panel                         |                           Add Account Type                            |                            Add User Account 1                             |
| :---------------------------------------------------------: | :-------------------------------------------------------------------: | :-----------------------------------------------------------------------: |
| <img src="Screenshots/Admin Panel.jpg" alt="Admin Panel" /> | <img src="Screenshots/Add Account Type.jpg" alt="Add Account Type" /> | <img src="Screenshots/Add User Account 1.jpg" alt="Add User Account 1" /> |

|                            Add User Account 2                             |                            Add Admin Account                            |                             Add Driver Account 1                              |                             Add Driver Account 2                              |
| :-----------------------------------------------------------------------: | :---------------------------------------------------------------------: | :---------------------------------------------------------------------------: | :---------------------------------------------------------------------------: |
| <img src="Screenshots/Add User Account 2.jpg" alt="Add User Account 2" /> | <img src="Screenshots/Add Admin Account.jpg" alt="Add Admin Account" /> | <img src="Screenshots/Add Driver Account 1.jpg" alt="Add Driver Account 1" /> | <img src="Screenshots/Add Driver Account 2.jpg" alt="Add Driver Account 2" /> |

<!-- Modify Account -->

### :four: Modify Account

|                              Modify Account Type 1                              |                              Select Account to Modify                               |                              Modify Account Options                               |                          Modify Email 1                           |
| :-----------------------------------------------------------------------------: | :---------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------: | :---------------------------------------------------------------: |
| <img src="Screenshots/Modify Account Type 1.jpg" alt="Modify Account Type 1" /> | <img src="Screenshots/Modify Account Type 2.jpg" alt="Select Account to Modify " /> | <img src="Screenshots/Modify Account Options.jpg" alt="Modify Account Options" /> | <img src="Screenshots/Modify Email 1.jpg" alt="Modify Email 1" /> |

|                          Modify Email 2                           |                           Modify Password                           |                              Modify User Account 1                              |                              Modify User Account 2                              |
| :---------------------------------------------------------------: | :-----------------------------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |
| <img src="Screenshots/Modify Email 2.jpg" alt="Modify Email 2" /> | <img src="Screenshots/Modify Password.jpg" alt="Modify Password" /> | <img src="Screenshots/Modify User Account 1.jpg" alt="Modify User Account 1" /> | <img src="Screenshots/Modify User Account 2.jpg" alt="Modify User Account 2" /> |

|                             Modify Driver Account 1                             |                            Modify Admin Account 2                             |
| :-----------------------------------------------------------------------------: | :---------------------------------------------------------------------------: |
| <img src="Screenshots/Modify Driver Account.jpg" alt="Modify Driver Account" /> | <img src="Screenshots/Modify Admin Account.jpg" alt="Modify Admin Account" /> |

<!-- Delete Account -->

### :five: Delete Account

|                              Delete Account Type 1                              |                              Delete Account Type 2                              |                              Delete Account Type 3                              |                              Delete Account Type 4                              |
| :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |
| <img src="Screenshots/Delete Account Type 1.jpg" alt="Delete Account Type 1" /> | <img src="Screenshots/Delete Account Type 2.jpg" alt="Delete Account Type 2" /> | <img src="Screenshots/Delete Account Type 3.jpg" alt="Delete Account Type 3" /> | <img src="Screenshots/Delete Account Type 4.jpg" alt="Delete Account Type 4" /> |

---

<!-- Directory Structure -->

## :file_folder: Directory Structure

<details>
     <summary> Anseo Admin </summary>
  
```
|-- lib
|   |-- config
|   |   '-- extensions.dart
|   |-- models
|   |   |-- account.dart
|   |   |-- admin.dart
|   |   |-- driver.dart
|   |   |-- record.dart
|   |   '-- user.dart
|   |-- pages
|   |   |-- account
|   |   |   |-- landing_page.dart
|   |   |   |-- sign_in.dart
|   |   |   '-- sign_up.dart
|   |   |-- home
|   |   |   '-- home.dart
|   |   |-- options
|   |   |   |-- add_account
|   |   |   |   |-- add_account_details.dart
|   |   |   |   '-- add_account.dart
|   |   |   |-- configure_travel_card
|   |   |   |   |-- configure_travel_cards.dart
|   |   |   |   '-- nfc_scan.dart
|   |   |   |-- delete_account
|   |   |   |   '-- delete_account.dart
|   |   |   |-- modify_account
|   |   |   |   |-- modify_account.dart
|   |   |   |   |-- modify_admin_account_details.dart
|   |   |   |   |-- modify_driver_account_details.dart
|   |   |   |   |-- modify_email.dart
|   |   |   |   |-- modify_password.dart
|   |   |   |   |-- modify_user_account_details.dart
|   |   |   |   '-- select_information_to_modify.dart
|   |   |   '-- view_account_list.dart
|   |-- services
|   |   |-- aes_encryption.dart
|   |   |-- firebase_auth.dart
|   |   '-- firebase_database.dart
|   |-- firebase_wrapper.dart
|   '-- main.dart
|-- assets
|   |-- icons
|   |   |-- account.png
|   |   |-- add.png
|   |   |-- delete.png
|   |   |-- edit.png
|   |   |-- email.png
|   |   |-- information.png
|   |   |-- password.png
|   |   '-- travel_card.png
|   |-- logo
|   |   '-- logo1_invert.png
|-- functions
|   '-- index.js
|-- pubspec.yaml
```

</details>

---

<!-- System Design -->

## :triangular_ruler: System Design

### :traffic_light: Methodology

Feature Driven Development (FDD), a part of the Agile Methodology, organizes software development around making progress on features in a systematically manner. This was the chosen methodology used in this application as FDD supports the dynamic evolvement of a feature including the inclusion and/or removal of designs and code, and the overall direction of the project.

Given how this project has multiple features to develop, it will allow for each feature to be developed thoroughly with a specific timeframe using sub-features.

To compensate for the potential decrease in documentation, a daily log with all the progress made regarding each feature will be written out whenever a development is being carried out.

Using GitHub as the choice for version control will also provide documentation on any changes that has occurred.

---

### :office: Three Tier Architecture

Anseo Admin is build upon a three-tier architecture model, as show above. With three-tier architecture, it's advantageous in that any changes made to one tier shouldn’t affect any other tiers in theory. The diagram shows the entities within each layer

<div align="center"> 
  <img src="..\System Design/Three Tier Architecture/anseo_validator_and_admin_3_tier_architecture.png" alt="Three Tier Architecture" />
</div>

---

### :cd: Database

The admin would need to be able to store their personal information on their account. As the application is developed, each account (user/driver/admin) will be assigned a list of privileges that will allow them to access certain features. The database has been implemented using Firebase Cloud Firestore, a NoSQL database. The following Entity Relationship Diagram highlight the fields necessary to create the database.

<div align="center"> 
  <img src="..\System Design/Entity Relational Diagram/Anseo Admin/Anseo Admin ERD.png" alt="Entity Relational Diagram" />
</div>

---

### :performing_arts: USE Case

Use Case Diagrams were created to represent the how the system would behave in line with the users interaction. It demonstrates the compulsory and extendable functionality that is applicable to the user when interacting with the system. In this case there is three actors – the commuter, the bus driver/operator and the admin. Each actor has access to certain functionalities and may share common functionalities with other actors.

<div align="center"> 
  <img src="..\System Design/USE Case Diagram/Anseo USE Case Diagram.png" alt="USE Case Diagram" />
</div>

---

### :art: Colour Scheme

<h4> Main Application</h4>

| Color            | Hex                                                                                                                               |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Primary Color    | ![#673AB7](https://via.placeholder.com/10/673AB7?text=+) #673AB7                                                                  |
| Secondary Color  | ![#9575CD](https://via.placeholder.com/10/9575CD?text=+) #9575CD                                                                  |
| Background Color | ![#FFFFFF](https://via.placeholder.com/10/FFFFFF?text=+) #FFFFFF                                                                  |
| Accent Color     | ![#9FA8DA](https://via.placeholder.com/10/9FA8DA?text=+) #9FA8DA                                                                  |
| Icon Gradient    | ![#1A6DFF](https://via.placeholder.com/10/1A6DFF?text=+) #1A6DFF ![#C822FF](https://via.placeholder.com/10/C822FF?text=+) #C822FF |
| Text Color       | ![#000000](https://via.placeholder.com/10/000000?text=+) #000000                                                                  |

---

<h4> Travel Cards </h4>

| Color               | Hex                                                                                                                                                                                                | Result                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Student Travel Card | ![#4158D0](https://via.placeholder.com/10/4158D0?text=+) #4158D0 ![#C850C0](https://via.placeholder.com/10/C850C0?text=+) #C850C0 ![#FFCC70](https://via.placeholder.com/10/FFCC70?text=+) #FFCC70 | <img src="..\System Design\Travelcards\student_card_1.jpg" alt="Student Travel Card" /> |
| Adult Travel Card   | ![#0061FF](https://via.placeholder.com/10/0061FF?text=+) #0061FF ![#60EFFF](https://via.placeholder.com/10/60EFFF?text=+) #60EFFF                                                                  | <img src="..\System Design\Travelcards\adult_card_1.jpg" alt="Adult Travel Card" />     |
| Child Travel Card   | ![#8EC5FC](https://via.placeholder.com/10/8EC5FC?text=+) #8EC5FC ![#E0C3FC](https://via.placeholder.com/10/E0C3FC?text=+) #E0C3FC                                                                  | <img src="..\System Design\Travelcards\child_card_1.jpg" alt="Child Travel Card" />     |

---

<h4> Logo </h4>

<table>
<tr><th>Colour</th><th>Result</th></tr>
<tr><td>

| Color           | Hex                                                                                                                               |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Logo Background | ![#FFFFFF](https://via.placeholder.com/10/FFFFFF?text=+) #FFFFFF                                                                  |
| Logo Text       | ![#4158D0](https://via.placeholder.com/10/4158D0?text=+) #4158D0 ![#C850C0](https://via.placeholder.com/10/C850C0?text=+) #C850C0 |

</td><td>

<img src="/Anseo Admin\anseo_admin\assets\logo\logo1_invert.png" alt="Anseo Admin Logo" />

</td></tr> </table>

---

<!--Plugins -->

## :electric_plug: Plugins

| Name                                                                          | Version  | Usage                                                                                                                           |
| ----------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------- | --- |
| [**encrypt**](https://pub.dev/packages/encrypt)                               | ^5.0.1   | Generate cryptographically secure random keys and IVs                                                                           |     |
| [**firebase_auth**](https://pub.dev/packages/firebase_auth)                   | ^3.3.13  | Enabling Android and iOS authentication using passwords, phone numbers and identity providers like Google, Facebook and Twitter |     |
| [**cloud_firestore**](https://pub.dev/packages/cloud_firestore)               | ^3.1.11  | Use the Cloud Firestore API a cloud-hosted, noSQL database with live synchronization                                            |     |
| [**nfc_manager**](https://pub.dev/packages/nfc_manager)                       | ^3.1.1   | Accessing the NFC features on Android and iOS                                                                                   |     |
| [**provider**](https://pub.dev/packages/provider)                             | ^6.0.2   | Dependency injection and state management                                                                                       |     |
| [**sweetsheet**](https://pub.dev/packages/sweetsheet)                         | ^0.4.0   | Show beautiful bottom sheet as confirmation dialog                                                                              |     |
| [**google_fonts**](https://pub.dev/packages/google_fonts)                     | ^2.3.1   | Use fonts from fonts.google.com                                                                                                 |     |
| [**flutter_native_splash**](https://pub.dev/packages/flutter_native_splash)   | ^2.1.2+1 | Customize Flutter's default white native splash screen with background color and splash image                                   |     |
| [**flutter_launcher_icons**](https://pub.dev/packages/flutter_launcher_icons) | ^0.9.2   | Updating application launcher icon                                                                                              |     |

---

<!-- Usage -->

## :construction: Development Process

The documentation process for Anseo Transit/Validator/Admin can be viewed [here](https://anseo.gitbook.io/anseo-documentation/)
