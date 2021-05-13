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
//    let friends: [User]
//    let users: [User]  // make moc?
    
    var body: some View {
        VStack {
            List(users) { user in
                VStack(alignment: .leading) {
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
                    Text("Friends:")
//                    ForEach(user.friendsArray, id: \.self) { friend in
//                        Text(friend.wrappedFriendName)
                    }
                }
            }
            

//            NavigationView {
//                List(friends, id: \.id) { item in
//                    // need to look up id off of User and pass to DetailViews
//                    NavigationLink(destination: DetailView(user: item,
//                                                           friends: findFriends(friends: item.friendsArray))) {
//                        Text(item.name)
//                            .font(.headline)
//                        Text(item.company)
//                            .foregroundColor(.secondary)
//                    }
//                }
//                .navigationTitle("\(user.name)'s friends")  // pull first name only
//            }
//        }
        .padding(.horizontal)
    }
    
//    func findFriends(friends: [Friend]) -> [User] {
//        // return a list of User items representing this user's friends
//        var userFriends = [User]()
//
//        for user in friends {
//            if let match = users.first(where: { $0.id == user.id}) {
//                userFriends.append(match)
//            } else {
//                fatalError("Missing \(user.wrappedName)")
//            }
//        }
//
//        return userFriends
//    }
    
    init(user: User) {
        self.user = user
//        self.friends = friends
//        self.users = users
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
