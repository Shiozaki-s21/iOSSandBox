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
import FirebaseStorage

class UserSettingViewController: UIViewController {

  var userModel: UserModel?

  let nameLabel: UITextField = UITextField()
  let uidTextField: UITextField = UITextField()
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
    pickImageFromLibrary()
  }
}

extension UserSettingViewController: UIImagePickerControllerDelegate {

  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

    let storage = Storage.storage()
//    let storageRef:StorageReference = storage.reference()
    let storageRef = storage.reference(forURL: "gs://authoringtest-8a6bc.appspot.com/")

    var userImage:UIImage = UIImage()

    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      // To upload editedImage to storage
      userImage = editedImage

    } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      userImage = originalImage

    }

    let fileName: String = "userProfImage/" + NSUUID().uuidString + "/" + userModel!.uid + ".png"
    let reference = storageRef.child(fileName)

    // TODO have to create function whihc translation png -> data
    reference.putData(userImage.pngData()!, metadata: nil) { (metadata, error) in
      if let error = error {
        print("error")
      } else {
        let size = metadata!.size
      }
    }
    dismiss(animated: true, completion: nil)




  }
}

extension UserSettingViewController: UINavigationControllerDelegate {
  func pickImageFromLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let controller = UIImagePickerController()
      controller.delegate = self
      controller.sourceType = .photoLibrary

      present(controller, animated: true, completion: nil)
    }
  }
}
