//
//  UserDetail.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct UserDetail: View {
    var fetchRequest: FetchRequest<User>
    var user: User? { fetchRequest.wrappedValue.first }

    init(userId: String) {
        fetchRequest = FetchRequest<User>(entity: User.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "id", userId))
    }

    var body: some View {
      List {
        Text("\(user?.name ?? "")")
        Text("\(user?.about ?? "")")
        ForEach(user?.friendsArray ?? [], id: \.self) { friend in
          NavigationLink(destination: UserDetail(userId: friend.wrappedID)) {
            Text("\(friend.wrappedName)")
            Text("\(friend.wrappedID)")
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
