//
//  ContentView.swift
//  FriendFace2
//
//  Created by Brandon Knox on 5/13/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                            .font(.headline)
                        Text(user.wrappedCompany)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("FriendFace Home")
        }
    }
    
    func loadData() {
        var loadedUsers = [UserStruct]()
        
        if !users.isEmpty {
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                if let decodedResponse = try?decoder.decode([UserStruct].self, from: data) {
                    DispatchQueue.main.async {
                        loadedUsers = decodedResponse
                        
                        var tmpUsers = [User]()

                        for usr in loadedUsers {
                            let rec = User(context: moc)
                            rec.name = usr.name
                            rec.id = usr.id
                            rec.isActive = usr.isActive
                            rec.age = Int16(usr.age)
                            rec.company = usr.company
                            rec.email = usr.email
                            rec.about = usr.about
                            rec.address = usr.address
                            rec.registered = usr.registered
                            rec.tags = usr.tags.joined(separator: ", ")
                            
                            tmpUsers.append(rec)
                        }
                        
                        for i in 0..<loadedUsers.count {
                            for friend in loadedUsers[i].friends {
                                if let newFriend = tmpUsers.first(where: { $0.id == friend.id }) {
                                    tmpUsers[i].addToFriends(newFriend)
                                }
                            }
                        }

                        do {
                            try moc.save()
                        }
                        catch let error {
                            print("Could not save data: \(error.localizedDescription)")
                        }
                    }
                    print("Results returned")
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            print(request)
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
