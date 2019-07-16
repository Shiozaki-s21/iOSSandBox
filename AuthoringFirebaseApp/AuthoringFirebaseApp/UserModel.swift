//
//  UserModel.swift
//  AuthoringFirebaseApp
//
//  Created by SubaruShiozaki on 2019-07-15.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import Foundation

class UserModel:NSObject {

  var uid:String
  var userName:String
  var bio:String
  var photoPath:String

  init(uid: String, userName: String, bio: String, photoPath: String) {
    self.uid = uid
    self.userName = userName
    self.bio = bio
    self.photoPath = photoPath
    super.init()
  }

}