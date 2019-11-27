//
//  UserInfoView.swift
//  FriendFace
//
//  Created by Mario Alberto Barragán Espinosa on 26/11/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI
import CoreData

struct UserInfoView: View {
    var user: User
    
    var body: some View {
        VStack {
            Text("Age \(user.age)")
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            Text("\(user.wrappedCompany)")
                    .bold()
                    .multilineTextAlignment(.center)
            Text("\(user.wrappedAddress)")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Text("About")
                .bold()
                .padding()
            Text("\(user.wrappedAbout)")
                .foregroundColor(.secondary)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let user = User(context: moc)
        user.age = 18
        user.email = "test@example.com"
        user.company = "Google"
        user.about = """
        Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n
        """
        return UserInfoView(user: user)
    }
}
