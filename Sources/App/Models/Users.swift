import Vapor
import Fluent
import FluentProvider

final class Users: Model {
    var firstName: String
    var lastName: String
    var email: String
    var companyName: String
    var title: String
    var companyDescription: String
    var phoneNumber: Int
    var companyAddress: String
    var companyPin: Int
    var companyAddressLine1: String
    var companyAddressLine2: String
    var companyURL: String
    var password: String
    
    let storage = Storage()
    init(firstName: String, lastName: String, email: String, companyName: String, title: String, companyDescription: String, phoneNumber: Int, companyAddress: String, companyPin: Int, companyAddressLine1: String, companyAddressLine2: String, companyURL: String, password: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.companyName = companyName
        self.title = title
        self.companyDescription = companyDescription
        self.phoneNumber = phoneNumber
        self.companyAddress = companyAddress
        self.companyPin = companyPin
        self.companyAddressLine1 = companyAddressLine1
        self.companyAddressLine2 = companyAddressLine2
        self.companyURL = companyURL
        self.password = password
        
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        
        try row.set("firstName", firstName)
        try row.set("lastName", lastName)
        try row.set("email", email)
        try row.set("companyName", companyName)
        try row.set("title", title)
        try row.set("companyDescription", companyDescription)
        try row.set("phoneNumber", phoneNumber)
        try row.set("companyAddress", companyAddress)
        try row.set("companyPin", companyPin)
        try row.set("companyAddressLine1", companyAddressLine1)
        try row.set("companyAddressLine2", companyAddressLine2)
        try row.set("companyURL", companyURL)
        try row.set("password", password)
        
        
        return row
    }
    
    init(row: Row) throws {
        firstName = try row.get("firstName")
        lastName = try row.get("lastName")
        email = try row.get("email")
        companyName = try row.get("companyName")
        title = try row.get("title")
        companyDescription = try row.get("companyDescription")
        phoneNumber = try row.get("phoneNumber")
        companyAddress = try row.get("companyAddress")
        companyPin = try row.get("companyPin")
        companyAddressLine1 = try row.get("companyAddressLine1")
        companyAddressLine2 = try row.get("companyAddressLine2")
        companyURL = try row.get("companyURL")
        password = try row.get("password")
        
    }
    
    
    
}

extension Users: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { users in
            users.id()
            users.string("firstName")
            users.string("lastName")
            users.string("email")
            users.string("companyName")
            users.string("title")
            users.string("companyDescription")
            users.int("phoneNumber")
            users.string("companyAddress")
            users.int("companyPin")
            users.string("companyAddressLine1")
            users.string("companyAddressLine2")
            users.string("companyURL")
            users.string("password")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
