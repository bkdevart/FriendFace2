//
//  User+CoreDataProperties.swift
//  FriendFace2
//
//  Created by Brandon Knox on 5/13/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedId: String {
        id ?? "Unknown id"
    }

    public var wrappedAbout: String {
        about ?? "Unknown about"
    }

    public var wrappedCompany: String {
        company ?? "Unknown company"
    }

    public var wrappedEmail: String {
        email ?? "Unknown email"
    }

    public var wrappedName: String {
        name ?? "Unknown name"
    }

    public var wrappedTags: String {
        tags ?? "Unknown tags"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }

    var formattedRegisteredDate: String {
        if let registeredDate = registered {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: registeredDate)
        } else {
            return "N/A"
        }
    }

    public var friendsArray: [User] {
        let set = friends as? Set<User> ?? []
        
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
    
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
