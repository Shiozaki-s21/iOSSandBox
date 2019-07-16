//
//  UserSettingViewController.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-07-09.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController {

  // user name label which is editable

  // user profile picture

  // user bio

  // submit button(if auto save doesn't work)

  let nameLabel: UILabel = UILabel()

  var userModel: UserModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.text = "false"
    nameLabel.text = userModel?.userName
    nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

  }

  //TODO To create user setting screen

  //TODO it must be had picture, bio, userName

}
