<div align="center">
  <img src="/Anseo Transit\journey_planner\assets\logo\my_logo_invert1.png" alt="logo" width="auto" height="auto" />
  <h4>
    <a href="/Video Demonstration">View Demo</a>
    <span> · </span>
    <a href="https://anseo.gitbook.io/anseo-documentation/">Documentation</a>
  </h4>

</div>

<br />

<!-- Table of Contents -->

# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)
- [Awards](#trophy-awards)
- [Applications](#iphone-applications)
  - [Anseo Transit](#one-anseo-transit)
  - [Anseo Validator](#two-anseo-validator)
  - [Anseo Admin](#three-anseo-admin)
- [Video Demonstration](#camera-video-demonstration)
- [Tech Stack](#space_invader-tech-stack)
  - [Programming Languages](#programming-languages)
  - [Front End](#front-end)
  - [Database](#database)
  - [Server](#server)
  - [Version Control](#version-control)
- [Getting Started](#toolbox-getting-started)
- [How to Operate?](#eyes-how-to-operate)

<br />

<!-- About the Project -->

## :star2: About the Project

This project is my dissertation that I completed in my final year of the **BSc in Computer Science** degree in **Technological University Dublin - City Campus**.

This project places emphasis on the workings behind a public transportation system that is used by daily commuters, public transport operators and administrations.

By upgrading the flaws surrounding these individual entities and providing solution to improve the interdependence between them, it can serve as a blueprint in how governments and public transportation operators alike can reform this sector to meet the needs and demands of commuters.

Three applications were developed and implemented to serve as a competitor to the current applications that exist in Ireland

<br />

<!-- Awards -->

## :trophy: Awards

This project won the TU Dublin Hothouse **_“Most Commercialisable Project”_** Prize at the TU Dublin Computer Science Project Fair 2022.

|                                   Project Fair Poster                                    |                                    Receiving Award                                    |                                    Crystal Award                                    |
| :--------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/46174096/204112149-2ce235c0-9dc8-4560-9380-786f475b0000.png" alt="Project Fair Poster" /> | <img src="https://user-images.githubusercontent.com/46174096/204112271-6a7e0454-1d5c-47f7-9b79-56a10c289e0e.png" alt="Receiving Award" /> | <img src="Screenshots/Real Time/Search by Stop Number 2.jpg" alt="Crystal Award" /> |

<br />

<!-- Applications -->

## :iphone: Applications

<!-- Anseo Transit-->

### :one: Anseo Transit

<table style="background-color: #fafafa;">
  <tr>
      <td>
          <img align="center" width="100%" src="/Anseo Transit\journey_planner\assets\logo\logo1.png" alt="screenshot">
      </td>
      <td>
          <p align="center">
An all-in-one public transportation application focused on making the commuters journey seamless and reliable.
          </p>
      </td>
  </tr>
  <tr>
      <td colspan="2">
      <h3 align="center">🎯 Features</h3>
<ul>
<li>Integrated Account Based Ticketing</li>
<li>View Available Seating on board a fleet</li>
<li>Real Time Information on multiple modes of public transportation</li>
    <li>Determine optimal route between two locations using multiple modes of transportation</li>
          </ul>
      </td>
    </tr>
</table>

<br />

<!-- Anseo Validator -->

### :two: Anseo Validator

<table style="background-color: #fafafa;">
  <tr>
    <td>
        <p align="center">
A validating application that allows drivers working with public transportation operators to verify the validity of a ticket and/or travel card and process payment on board a fleet via QR code/NFC capabilities.         </p>
     </td>
      <td>
          <img align="center" width="500" height="auto" src="/Anseo Validator\validator\assets\logo\logo1_black.png" alt="screenshot">
      </td>
  </tr>
    <tr>
      <td colspan="2">
      <h3 align="center">🎯 Features</h3>
<ul>
<li> Select the route, fare type and payment method
</li>
<li>Scan NFC travel cards and decrypt the data within the NFC travel card
</li>
<li>Scan QR codes and decrypt the data within the QR code</li>
<li>Create/Update transactions to the Firebase Cloud Firestore database and display results to user
</li>
          </ul>
      </td>
    </tr>
</table>

<br />

<!-- Anseo Admin -->

### :three: Anseo Admin

<table style="background-color: #fafafa;">
  <tr>
    <td><img align="center" width="500" height="auto" src="/Anseo Admin\anseo_admin\assets\logo\logo1_invert.png" alt="screenshot"></td>
    <td><p align="center">
An administration application which offers safe and secure management of various accounts and configuration of fare types.        </p></td>
  </tr>
 <tr>
      <td colspan="2">
      <h3 align="center">🎯 Features</h3>
<ul>
<li>Configure an NFC travel card to contain a fare type</li>
    <li>Create a <i><b>User</b>/<b>Driver</b>/<b>Admin</b> account</i></li>
<li> Modify email, password and personal 
information of a <i><b>User</b>/<b>Driver</b>/<b>Admin</b> account</i></li>
<li>Delete a <i><b>User</b>/<b>Driver</b>/<b>Admin</b> account</i></li>
          </ul>
      </td>
    </tr>
</table>

<br />

<!-- Video Demonstration -->

## :camera: Video Demonstration

<div align="center">
    <h3>Anseo Transit</h3>
    <video width="100%" controls src="https://user-images.githubusercontent.com/46174096/203685586-3673811d-e357-4763-98d3-19efe0f4d907.mp4" type="video/mp4">
	</video> 
</div>

<br/>

<div align="center">
    <h3>Anseo Validator</h3>
    <video width="100%" controls src="https://user-images.githubusercontent.com/46174096/203685632-f8c62eed-d7da-4d8e-8641-3f89f5033849.mp4" type="video/mp4">
	</video> 
</div>

<br/>

<div align="center">
    <h3>Anseo Admin</h3>
    <video width="100%" controls src="https://user-images.githubusercontent.com/46174096/203685650-1ae91435-7c48-4154-859d-bb7c0a0eb4f5.mp4" type="video/mp4">
	</video> 
</div>

<br />

<!-- TechStack -->

## :space_invader: Tech Stack

### Programming Languages

These are the programming languages that were utilised to implement the important business logic of the application:

- <img src="https://img.icons8.com/color/64/000000/dart.png" style="vertical-align:middle"/> [Dart](https://dart.dev/) is a type safe, general-purpose, object-orientated programming language that’s designed for building fast applications on multiple devices.
- <img src="https://img.icons8.com/nolan/64/1A6DFF/C822FF/python.png" style="vertical-align:middle"/> [Python](https://www.python.org/) is a dynamically typed, multi-paradigm programming language that supports object-orientated, functional and logic programming

<br />

### Front End

These are the technologies that were utilised to build the user experience, including the user interface and the client-side functionality of the application:

- <img src="https://img.icons8.com/color/64/000000/flutter.png" style="vertical-align:middle"/> [Flutter](https://flutter.dev) is a Software Development Kit that allows users to build and run native compiled applications for web, desktop, iOS and Android from a single codebase.
- <img src="https://img.icons8.com/nolan/64/1A6DFF/C822FF/raspberry-pi.png" style="vertical-align:middle"/> [Raspberry Pi](https://www.raspberrypi.com) is a low cost, credit-card sized computer that runs on the Linux operating system. With multiple ports and GPIO (general purpose input/output) pins, it is perfect for programming, hardware projects, home automation and Internet of Things.
- <img src="https://img.icons8.com/fluent/64/000000/nfc-logo.png" style="vertical-align:middle"/> [Near Field Communication (NFC)](https://en.wikipedia.org/wiki/Near-field_communication) is based on the adaptation of Radio-Frequency Identification (RFID) technology. Its primary function is to store and transmit data between other NFC devices, without the requirement for power
- <img src="https://img.icons8.com/nolan/64/qr-code.png" style="vertical-align:middle"/> [QR Code](https://en.wikipedia.org/wiki/QR_code) or Quick Response Code is a two-dimensional black & white square barcode which can store and convey information such as Uniform Resource Locator (URL) links, data authentication and payment transactions

<br />

### Database

Below shows the technologies utilised for storing and quering data within the application:

- <img src="https://img.icons8.com/color/64/000000/firebase.png" style="vertical-align:middle"/> [Firebase](https://firebase.google.com/) is a Cloud-hosted, NoSQL database built on the Google infrastructure. Using a document-model, it allows to data to be stored, scaled and synchronized in real time among users.

<br />

### Server

These are the technologies that allows the application to send and receive requests, run smoothly, provide structure and scale capacity as needed:

- <img src="https://docs.opentripplanner.org/en/latest/images/otp-logo.svg" alt="logo" width="64" height="auto" style="vertical-align:middle"/> [OpenTripPlanner](https://www.opentripplanner.org/) is a cross-platform, open-source, multi-modal trip planner. It allow users to plan the best possible trips with multiple modes of transportation including bus, train, tram, walking, bike and driving using GTFS and OpenStreetMap
- <img src="https://img.icons8.com/nolan/64/1A6DFF/C822FF/order-on-the-way.png" style="vertical-align:middle"/> [General Transit Feed Specification (GTFS)](https://gtfs.org/) is a standardised format for public transportation schedules with geographical data. Written in comma separated values (CSV) files, each compressed ZIP file has information pertaining to the public transportation operators including stops, routes, trips and calendar
- <img src="https://seeklogo.com/images/M/mapbox-logo-D6FDDD219C-seeklogo.com.png" alt="logo" width="64" height="auto" style="vertical-align:middle"/> [Mapbox](https://www.mapbox.com/) is a map service that allows for creating custom maps and interactive data visualisations.
- <img src="https://img.icons8.com/nolan/64/stripe.png" style="vertical-align:middle"/> [Stripe](https://stripe.com/ie) is an online payment solution that allows users to process and receive payments.

<br />

### Version Control

These were the frameworks utilised in order to track and manage changes to the codebase/files of the application:

- <img src="https://img.icons8.com/nolan/64/1A6DFF/C822FF/github.png" style="vertical-align:middle"/><img src="https://img.icons8.com/nolan/64/git.png" style="vertical-align:middle"/> [Github](https://github.com/) / [Git](https://git-scm.com/) is a platform that allow users to perform version control on their projects using a web and/or desktop graphical interface powered by the Git Repository

<br />

<!-- Getting Started -->

## :toolbox: Getting Started

Have a look at the documentation [here](https://anseo.gitbook.io/anseo-documentation/) to get started.

<br />

<!-- Usage -->

## :eyes: How to Operate?

For documentation and detailed explanation of how to use each application, please refer to each application directory below.

<table>
  <tr align="center">
    <td><a href="/Anseo Transit">Anseo Transit</a></td>
      <td><a href="/Anseo Validator">Anseo Validator</a></td>
      <td><a href="/Anseo Admin">Anseo Admin</a></td>
  </tr>
  <tr>
    <td><img src="/Anseo Transit\journey_planner\assets\logo\logo1.png" ></td>
    <td><img src="/Anseo Validator\validator\assets\logo\logo1_black.png" width="350" ></td>
    <td><img src="/Anseo Admin\anseo_admin\assets\logo\logo1_invert.png" width="400" style="background-color:#f5f5f5"></td>
  </tr>
</table>
