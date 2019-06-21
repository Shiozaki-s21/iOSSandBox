//
//  ViewController.swift
//  ConnectingFireBase
//
//  Created by SubaruShiozaki on 2019-06-18.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
  
  // create class member
  var dataBaseRef:DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // create instance
    dataBaseRef = Database.database().reference()
//    storeNewUser()
    loadUser()
  }

  // store one user as a new user
  func storeNewUser() {
    print("start")
    self.dataBaseRef.child("users").setValue(["username":"Kazu"])
    print("end")
  }

  func loadUser() {
    self.dataBaseRef.child("users").observe(.value) { (snap: DataSnapshot) in
      let dict = snap.value as? [String:AnyObject] ?? [:]
      print(dict["username"]!)
    }
  }
}

