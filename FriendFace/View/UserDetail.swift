//
//  UserDetail.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct UserDetail: View {

    var user: User?

    init(userId: String) {
      let currentUser = UserArray.shared.users.first(where: { $0.id == userId })
      self.user = currentUser
    }

    var body: some View {
      List {
        Text("\(user?.name ?? "")")
        Text("\(user?.about ?? "")")
        ForEach(user?.friends ?? [], id: \.self) { friend in
          NavigationLink(destination: UserDetail(userId: friend.id)) {
            Text("\(friend.name)")
            Text("\(friend.id)")
          }
        }
      }
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
      UserDetail(userId: "Hello")
    }
}
