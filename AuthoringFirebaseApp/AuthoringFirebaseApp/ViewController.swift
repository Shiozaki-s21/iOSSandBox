//
//  ViewController.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-06-23.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // label
  let titleLabel:UILabel = UILabel()
  
  // textbox
  let emaliTextBox:UITextField = UITextField()
  let passwordTextBox:UITextField = UITextField()
  
  // button
  let loginButton:UIButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    createSignInView()
  }



  @objc func tappedSignIn(sender:Any) {
   print("kicked method") 
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
}

