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
  
  // user name label which is editable
  
  // user profile picture
  
  // user bio
  
  // submit button(if auto save doesn't work)
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
    
    
  }
}

extension UserSettingViewController:UIImagePickerControllerDelegate {
  
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let storage = Storage.storage()
    let storageRef = storage.reference(forURL: "gs://authoringtest-8a6bc.appspot.com/")
    
    if let data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage) {
      let reference = storageRef.child("image/" + NSUUID().uuidString + "/" + countPhoto() + ".jpg")
      reference.put(data, metadata: nil, completion: { metaData, error in
        print(metaData)
        print(error)
      })
      dismiss(animated: true, completion: nil)
    }
    
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
