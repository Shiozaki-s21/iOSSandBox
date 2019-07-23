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

    userPhoto.translatesAutoresizingMaskIntoConstraints = false
    userPhoto.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    userPhoto.widthAnchor.constraint(equalToConstant: 512).isActive = true


    // store picture here from fire storage
    // create reference
    let fileName: String = "userProfImage/" + userModel!.uid + ".png"
    let storage = Storage.storage()
    let pathReference = storage.reference(withPath: fileName)
//    let gsReference = storage.reference(forURL: "gs://authoringtest-8a6bc.appspot.com/")
    let gsReference = storage.reference()
    gsReference.child(fileName)

    // try to load picture data
    pathReference.getData(maxSize: 1 * 128 * 128){ data, error in
      if let error = error {
        print("Error:" + error.localizedDescription)
      } else {
        print("load")
        let image = UIImage(data: data!)
        self.userPhoto.setImage(image, for: .normal)
      }
    }
      // if data is existing, set it to view
      // if it's not existing, set default picture

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

    let fileName: String = "userProfImage/" + userModel!.uid + ".png"
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
    loadView()
    viewDidLoad()
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
