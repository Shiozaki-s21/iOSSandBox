//
//  SignInViewController.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-06-27.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

class SignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
  
  let db = Firestore.firestore()
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
    if let error = error {
      return
    }
    
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
    // To sing-in process
    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
      if let error = error {
        // Error process
        print("Error")
      } else {
        // Login process
        print("Login")
        
        // TODO To create user data
        // uid, userName(what is a default?)
        // How should I do about "Same User name problem"
        // 1. accepted same name
        // 2. to use uid and show it on public
        // 3. create another id as a showing
        // 4, create another random id as a showing
        // 5. doesn't accepted same name -> ☆
        
        let loginUser = Auth.auth().currentUser
        
        let usersRef = self.db.collection("users")
        
        // To change to sync process
        usersRef.whereField("uid", isEqualTo: loginUser!.uid).getDocuments(){ (snaps, err) in
          if let err = err {
            print("err")
          } else {
            if snaps!.isEmpty {
              //               not existing user data
              usersRef.addDocument(data: [
                "uid": String(loginUser!.uid),
                "userName": "hugahuga",
                "bio": "test",
                "photoPath":""
              ])
            }
          }
          self.performSegue(withIdentifier: "signinToUserSetting", sender: nil)
        }
        
        
        
        //          self.db.collection("users").whereField("uid", isEqualTo: loginUser!.uid).getDocuments() { (snaps, err) in
        //          if let err = err {
        //            print("Error for getting users")
        //          } else {
        //            // when users has same uid data
        //            for document in snaps!.documents {
        //              print("Do segueing without creating user data")
        //              self.performSegue(withIdentifier: "signinToUserSetting", sender: nil)
        //            }
        //          }
        //        }
        
        // if users doesn't have uid, segue ,create my information and segue
        // To create user method
        // TODO check rule for writing and reading on Firestore
        //        var ref:DocumentReference? = nil
        //        print("Do segueing with creating user data")
        //        ref = self.db.collection("users").addDocument(data: [
        //          "uid": String(loginUser!.uid),
        //          "userName": "hugahuga",
        //          "bio": "test",
        //          "photoPath":""
        //        ]) { err in
        //          if let err = err {
        //            print("Error adding document: \(err)")
        //          } else {
        //            print("Document added with ID: \(ref!.documentID)")
        //          }
        //        }
//        self.performSegue(withIdentifier: "signinToUserSetting", sender: nil)
      }
    }
  }
  
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    // TODO Perform any operations when the user disconnects from app here.
  }
  
  
  
  // label
  let titleLabel:UILabel = UILabel()
  
  // textbox
  let emaliTextBox:UITextField = UITextField()
  let passwordTextBox:UITextField = UITextField()
  
  // button
  let loginButton:UIButton = UIButton()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
    // to create UI
    //    createSignInView()
    createGoogleSignIn()
    
    // to implement setting delegate
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().signIn()
    
  }
  
  
  fileprivate func createGoogleSignIn() {
    let googleButton:GIDSignInButton = GIDSignInButton()
    googleButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(googleButton)
    googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    googleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
  }
  
  fileprivate func createSignInView() {
    // creating UI
    // title label
    view.addSubview(titleLabel)
    titleLabel.textAlignment = .center
    titleLabel.text = "SIGN IN"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0).isActive = true
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.adjustsFontForContentSizeCategory = true
    
    // create group for input text boxes
    let inputStackView: UIStackView = UIStackView()
    view.addSubview(inputStackView)
    inputStackView.translatesAutoresizingMaskIntoConstraints = false
    inputStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    inputStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    inputStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    inputStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    inputStackView.axis = .vertical
    inputStackView.alignment = .center
    inputStackView.distribution = .fillProportionally
    
    // implement emailTextBox
    inputStackView.addArrangedSubview(emaliTextBox)
    emaliTextBox.translatesAutoresizingMaskIntoConstraints = false
    emaliTextBox.widthAnchor.constraint(equalTo: inputStackView.widthAnchor).isActive = true
    emaliTextBox.placeholder = "email"
    
    // implement passwordBox
    inputStackView.addArrangedSubview(passwordTextBox)
    passwordTextBox.translatesAutoresizingMaskIntoConstraints = false
    passwordTextBox.widthAnchor.constraint(equalTo: inputStackView.widthAnchor).isActive = true
    passwordTextBox.placeholder = "password"
    
    // implement sign in button
    view.addSubview(loginButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.backgroundColor = .blue
    loginButton.setTitle("sign in", for: .normal)
    loginButton.addTarget(self, action: #selector(tappedSignIn(sender:)), for: .touchUpInside)
    loginButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    
  }
  
  @objc func tappedSignIn(sender:UIButton) {
    Auth.auth().signIn(withEmail: emaliTextBox.text!, password: passwordTextBox.text!) { (user, error) in
      if error != nil {
        print("Failed")
      } else {
        print("Success")
      }
    }
  }
}
