/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: index.js
  File Description: Cloud Functions used to provide admin authentication with Firebase
*/

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/* 
  Old functions that were implemented when I was trying to figure out how 
  to get a specific account/get all accounts stored in the firebase database
*/

// const getAllUsers = async (req, res) => {
//   var allUsers = [];
//   return admin
//     .auth()
//     .listUsers()
//     .then(function (listUsersResult) {
//       listUsersResult.users.forEach(function (userRecord) {
//         // For each user
//         var userData = userRecord.toJSON();
//         allUsers.push(userData);
//       });
//       res.status(200).send(JSON.stringify(allUsers));
//     })
//     .catch(function (error) {
//       console.log("Error listing users:", error);
//       res.status(500).send(error);
//     });
// };

// const getSpecificUser = async (req, res) => {
//   return admin
//     .auth()
//     .getUser(req.body.uid)
//     .then(function (listUserResult) {
//       res.status(200).send(JSON.stringify(listUserResult));
//     })
//     .catch(function (error) {
//       console.log("Error listing users:", error);
//       res.status(500).send(error);
//     });
// };

/*
  Cloud Function that updates the email associated with the account by passing the 
  UID of the account and the new email.If sucessful a 200 Status code is sent back 
  alongside the results of the changes. Otherwise, a 500 Status code is sent back 
  alongside the error message
*/
const updateSpecificUserEmail = async (req, res) => {
  return admin
    .auth()
    .updateUser(req.body.uid, {
      email: req.body.email,
    })
    .then(function (updatedUserResult) {
      res.status(200).send(JSON.stringify(updatedUserResult));
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that updates the password associated with the account by passing the 
  UID of the account and the new password. If sucessful a 200 Status code is sent back 
  alongside the results of the changes. Otherwise, a 500 Status code is sent back 
  alongside the error message
*/
const updateSpecificUserPassword = async (req, res) => {
  return admin
    .auth()
    .updateUser(req.body.uid, {
      password: req.body.password,
    })
    .then(function (updatedUserResult) {
      res.status(200).send(JSON.stringify(updatedUserResult));
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that deletes a specified account by passing the UID of the account. 
  If sucessful a 200 Status code is sent back alongside the results of the changes. 
  Otherwise, a 500 Status code is sent back alongside the error message
*/
const deleteSpecificUser = async (req, res) => {
  return admin
    .auth()
    .deleteUser(req.body.uid)
    .then(() => {
      res.status(200).send();
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that assigns the account with user privilages by setting the token 
  of 'user' as true, while 'driver' and 'admin' are set to false, If sucessful a 
  200 Status code is sent back alongside the results of the changes. Otherwise, a 
  500 Status code is sent back alongside the error message
*/
const setUserAccountPrivilages = async (req, res) => {
  return admin
    .auth()
    .setCustomUserClaims(req.body.uid, {
      user: true,
      driver: false,
      admin: false,
    })
    .then(() => {
      res.status(200).send();
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that assigns the account with driver privilages by setting the token 
  of 'driver' as true, while 'user' and 'admin' are set to false, If sucessful a 
  200 Status code is sent back alongside the results of the changes. Otherwise, a 
  500 Status code is sent back alongside the error message
*/
const setDriverAccountPrivilages = async (req, res) => {
  return admin
    .auth()
    .setCustomUserClaims(req.body.uid, {
      driver: true,
      user: false,
      admin: false,
    })
    .then(() => {
      res.status(200).send();
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that assigns the account with admin privilages by setting the token 
  of 'admin' as true, while 'driver' and 'user' are set to false, If sucessful a 
  200 Status code is sent back alongside the results of the changes. Otherwise, a 
  500 Status code is sent back alongside the error message
*/
const setAdminAccountPrivilages = async (req, res) => {
  return admin
    .auth()
    .setCustomUserClaims(req.body.uid, {
      admin: true,
      user: false,
      driver: false,
    })
    .then(() => {
      res.status(200).send();
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

/*
  Cloud Function that creates a new account by passing the email and password inputted. 
  If sucessful a 200 Status code is sent back alongside the ID of the newly created 
  account. Otherwise, a 500 Status code is sent back alongside the error message
*/
const createUserAccount = async (req, res) => {
  return admin
    .auth()
    .createUser({
      email: req.body.email,
      password: req.body.password,
    })
    .then((userRecord) => {
      res.status(200).send(userRecord.uid);
    })
    .catch(function (error) {
      console.log("Error listing users:", error);
      res.status(500).send(error);
    });
};

module.exports = {
  // api: functions.https.onRequest(getAllUsers),
  // getSpecificUser: functions.https.onRequest(getSpecificUser),
  updateSpecificUserEmail: functions.https.onRequest(updateSpecificUserEmail),
  updateSpecificUserPassword: functions.https.onRequest(
    updateSpecificUserPassword
  ),
  deleteSpecificUser: functions.https.onRequest(deleteSpecificUser),
  setUserAccountPrivilages: functions.https.onRequest(setUserAccountPrivilages),
  setDriverAccountPrivilages: functions.https.onRequest(
    setDriverAccountPrivilages
  ),
  setAdminAccountPrivilages: functions.https.onRequest(
    setAdminAccountPrivilages
  ),
  createUserAccount: functions.https.onRequest(createUserAccount),
};
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
