//
//  ContentView.swift
//  FriendFace
//
//  Created by Mario Alberto Barragan Espinosa on 11/25/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userArray = UserArray.shared
    @State private var isLoadingUsers = true

    var body: some View {
      NavigationView {
        VStack {
          List {
            ForEach(userArray.users, id: \.self) { user in
              NavigationLink(destination: UserDetail(userId: user.id)) {
                Text("\(user.name)")
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
        if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
          DispatchQueue.main.async {
            self.userArray.users = decodedUsers
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
