//
//  UserSettingViewController.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-07-09.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore


class UserSettingViewController: UIViewController {

  var userModel: UserModel?
  
  let nameLabel: UITextField = UITextField()
  let uidTextField:UITextField = UITextField()
  @IBOutlet var userPhoto: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.text = userModel?.userName
    nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    //    userPhoto.translatesAutoresizingMaskIntoConstraints = false
  }
  
  @IBAction func uploadPhoto(_ sender: UIButton) {
    print("upload button")
    pickImageFromLibrary()
  }
}

extension UserSettingViewController:UIImagePickerControllerDelegate {
  
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let storage = Storage.storage().reference()
    let imageSelf = storage.child("userProfImage")
//    let storageRef = storage.reference(forURL: "gs://authoringtest-8a6bc.appspot.com/")
    print("Imagepicker")
  }
}

extension UserSettingViewController:UINavigationControllerDelegate {
  func pickImageFromLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let controller = UIImagePickerController()
      controller.delegate = self
      controller.sourceType = .photoLibrary
      
      present(controller, animated: true, completion: nil)
    }
  }
}
