//
//  UserArray.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import Foundation

class UserArray: ObservableObject {
    @Published var persons = [UserDTO]()
    
    static let shared = UserArray()
    private init(){}
}
