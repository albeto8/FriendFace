//
//  FriendCellView.swift
//  FriendFace
//
//  Created by Mario Alberto Barragán Espinosa on 26/11/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import CoreData
import SwiftUI

struct FriendCellView: View {
    var friend: Friend
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(friend.wrappedName)")
                .foregroundColor(.secondary)
        }
    }
}

struct FriendCellView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let friend = Friend(context: moc)
        friend.name = "Martin Rodriguez"
        return FriendCellView(friend: friend)
    }
}
