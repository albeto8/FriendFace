//
//  ContentView.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    @ObservedObject var userArray = UserArray.shared
    @State private var isLoadingUsers = true

    var body: some View {
      NavigationView {
        VStack {
          List {
            ForEach(self.users, id: \.self) { user in
              NavigationLink(destination: UserDetail(userId: user.wrappedID)) {
                Text("\(user.wrappedName)")
              }
            }
          }
        }
        .onAppear(perform: fetchUsers)
        .navigationBarTitle(self.isLoadingUsers ? "Loading..." : "Users")
      }
    }

  func fetchUsers() {
      self.isLoadingUsers = true
    guard self.users.count == 0 else {
        self.isLoadingUsers = false
        return
    }
      let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
      var request = URLRequest(url: url)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpMethod = "GET"
      URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
              print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
              self.isLoadingUsers = false
              return
          }
        if let decodedUsers = try? JSONDecoder().decode([UserDTO].self, from: data) {
          DispatchQueue.main.async {
            self.userArray.persons = decodedUsers
            for userDTO in decodedUsers {
                let user = User(context: self.moc)
                user.id = UUID(uuidString: userDTO.id)
                user.isActive = userDTO.isActive
                user.name = userDTO.name
                user.age = Int16(userDTO.age)
                user.company = userDTO.company
                user.email = userDTO.email
                user.address = userDTO.address
                user.about = userDTO.about
                user.registered = userDTO.registered
                //user.tags = userDTO.tags
                for friendDTO in userDTO.friends ?? [] {
                    let friend = Friend(context: self.moc)
                    friend.id = UUID(uuidString: friendDTO.id)
                    friend.name = friendDTO.name
                    user.addToFriends(friend)
                }
            }
            try? self.moc.save()
            self.isLoadingUsers = false
          }
        } else {
            print("Invalid response from server")
            self.isLoadingUsers = false
        }
      }.resume()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
