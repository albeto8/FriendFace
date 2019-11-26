//
//  User.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import Foundation

struct UserDTO: Codable, Hashable {
  let id: String
  let isActive: Bool
  let name: String
  let age: Int
  let company: String
  let email: String
  let address: String
  let about: String
  let registered: String
  let tags: [String]
  let friends: [FriendDTO]?

  struct FriendDTO: Codable, Hashable {
    let id: String
    let name: String
  }
}

