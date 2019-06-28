//
//  SignInViewController.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-06-27.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

  // label
  let titleLabel:UILabel = UILabel()

  // textbox
  let emaliTextBox:UITextField = UITextField()
  let passwordTextBox:UITextField = UITextField()

  // button
  let loginButton:UIButton = UIButton()

  override func viewDidLoad() {

    super.viewDidLoad()

    createSignInView()
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
    loginButton.addTarget(self, action: #selector(tappedSignIn(sender:)), for: .touchDown)
    loginButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true


    // create stackView for whole view
    let wholeView: UIStackView = UIStackView()
    view.addSubview(wholeView)
    wholeView.translatesAutoresizingMaskIntoConstraints = false
    wholeView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    wholeView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    wholeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    wholeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    wholeView.distribution = .fillEqually
    wholeView.alignment = .center
    wholeView.axis = .vertical
  }

  @objc func tappedSignIn(sender:Any) {
    print("kicked method")
  }

}
