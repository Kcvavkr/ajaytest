import Vapor
import FluentProvider


extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, World!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        get("register") { request in
            return try self.view.make("Register.html")
        }
        post("register") { request in
            //TODO: verify non nilvalues
            
            let firstName = request.data["FirstName"]?.string!
            let lastName = request.data["LastName"]?.string!
            let companyName = request.data["CompanyName"]?.string
            let title = request.data["JobTitle"]?.string
            let email = request.data["Email"]?.string!
            let phoneNumber = request.data["PhoneNumber"]?.int!
            let companyDescription = request.data["CompanyDescription"]?.string
            let companyAddressLine1 = request.data["CompanyAddress1"]?.string!
            let companyAddressLine2 = request.data["CompanyAddress2"]?.string
            let companyAddressPin = request.data["CompanyPin"]?.int
            let companyAddress = request.data["CompanyAddress"]?.string
            let companyURL = request.data["CompanyURL"]?.string!
            let password = request.data["Password"]?.string!
            let passwordVerify = request.data["PasswordVerify"]?.string!
            
            if password != passwordVerify {
                //TODO: Password Missmatch
            }
            
            if (try Users.makeQuery().filter("email", email ?? "").first()) != nil {
                //TODO: make HTML page or return JSON
                return "error. email id already registered to user"
            }
            
            let vendor = Users(firstName: firstName ?? "error", lastName: lastName ?? "error", email: email ?? "error", companyName: companyName ?? "error", title: title ?? "error", companyDescription: companyDescription ?? "error", phoneNumber: phoneNumber ?? 00000, companyAddress: companyAddress ?? "error", companyPin: companyAddressPin ?? 00000, companyAddressLine1: companyAddressLine1 ?? "error", companyAddressLine2: companyAddressLine2 ?? "error", companyURL: companyURL ?? "error", password: password ?? "error")
            
            try vendor.save()
            print(vendor.id!)
            
            
            
            
            
            return "\(firstName ?? "err_1") \(lastName ?? "err_1") \(companyName ?? "err_1") \(title ?? "err_1") \(email ?? "err_1") \(phoneNumber ?? 00000) \(companyDescription ?? "err_1") \(companyAddressLine1 ?? "err_1") \(companyAddressLine2 ?? "err_1") \(companyAddressPin ?? 00000) \(companyURL ?? "err_1") \(password ?? "err_1") \(passwordVerify ?? "err_1") user id: \(vendor.id ?? "error")"
        
        }
        
        
        
        get("Search", ":email") { request in
            guard let name = request.parameters["email"]?.string else {
                throw Abort.badRequest
            }
            guard let user = try Users.makeQuery().filter("email", name).first() else {
                throw Abort.notFound
            }
            return "\(user.email), \(user.firstName) \(user.lastName)"
        }
        
        get("login") { request in
            return try self.view.make("login.html")
        }
        
        post("login") { request in
            //            TODO: appropriate screen for invalid username and password
            guard let email = request.data["emailInput"]?.string else {
                throw Abort.badRequest
            }
            guard let password = request.data["passwordInput"]?.string else {
                throw Abort.badRequest
            }
            
            guard let user = try Users.makeQuery().filter("email", email).first() else {
                return "error. not a user"
            }
            
            guard user.password == password else {
                return "error. invalid password"
            }
            
            return "success"
        }
        
        get("") { req in
            return try self.view.make("index.html")
         }
        
        post("employee", "make") { request in
            guard let contractName = request.data["contractName"]?.string else {
                throw Abort.badRequest
            }
            guard let contractDeliveryDate = request.data["contractDeliveryDate"]?.date else {
                throw Abort.badRequest
            }
            guard let contractLocation = request.data["contractLocation"]?.string else {
                throw Abort.badRequest
            }
            guard let instillationRequired = request.data["instillationRequired"]?.bool else {
                throw Abort.badRequest
            }
            guard let contractTechnicalRequirenments = request.data["contractTechnicalRequirenments"]?.string else {
                throw Abort.badRequest
            }
            guard let contractDescription = request.data["contractDescription"]?.string else {
                throw Abort.badRequest
            }
            
            
            let contract = Contracts(contractName: contractName, contractDeliveryDate: contractDeliveryDate, contractLocation: contractLocation, instillationRequired: instillationRequired, contractTechnicalRequirenments: contractTechnicalRequirenments, contractDescription: contractDescription )
            
            if let contractCheck = try Contracts.makeQuery().filter("contractName", contractName).first() {
                //                TODO: handle Registered User
                
                return "error. contract name \(contractCheck.contractName) is already taken by another contract this year."
            }
            
            
            try contract.save()
            
            return "success"
        }
        
        
        
        
    }
}
