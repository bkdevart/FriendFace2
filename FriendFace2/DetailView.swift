//
//  DetailView.swift
//  FriendFace2
//
//  Created by Brandon Knox on 5/13/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    let user: User
    
    var body: some View {
        VStack {
            Text(user.wrappedName)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(user.wrappedCompany)
                .foregroundColor(.secondary)
            Text("Age: " + String(user.age))
                .font(.caption)
            Text(user.wrappedAbout)
            Text("Member since \(user.formattedRegisteredDate)")
                .font(.footnote)
            NavigationView {
                List(user.friendsArray) { friend in
                    NavigationLink(destination: DetailView(user: friend)) {
                        Text(friend.wrappedName)
                            .font(.headline)
                        Text(friend.wrappedCompany)
                            .foregroundColor(.secondary)
                    }
                }
                .navigationTitle("\(user.wrappedName)'s friends")  // pull first name only
            }
        }
        .padding(.horizontal)
    }
    
    init(user: User) {
        self.user = user
    }
}
