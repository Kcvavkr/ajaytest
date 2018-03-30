import Vapor
import Fluent
import FluentProvider

final class Contracts: Model {
    var contractName: String
    var contractDeliveryDate: Date
    var contractLocation: String
    var instillationRequired: Bool
    var contractTechnicalRequirenments: String
    var contractDescription: String

    
    
    let storage = Storage()
    init(contractName: String, contractDeliveryDate: Date, contractLocation: String, instillationRequired: Bool, contractTechnicalRequirenments: String, contractDescription: String) {
        self.contractName = contractName
        self.contractDeliveryDate = contractDeliveryDate
        self.contractLocation = contractLocation
        self.instillationRequired = instillationRequired
        self.contractTechnicalRequirenments = contractTechnicalRequirenments
        self.contractDescription = contractDescription
       
    }
    
    
    func makeRow() throws -> Row {
        var row = Row()
        
        try row.set("contractName", contractName)
        try row.set("contractDeliveryDate", contractDeliveryDate)
        try row.set("contractLocation", contractLocation)
        try row.set("instillationRequired", instillationRequired)
        try row.set("contractTechnicalRequirenments", contractTechnicalRequirenments)
        try row.set("contractDescription", contractDescription)

        return row
        
    }
    
    
    init(row: Row) throws {
        contractName = try row.get("contractName")
        contractDeliveryDate = try row.get("contractDeliveryDate")
        contractLocation = try row.get("contractLocation")
        instillationRequired = try row.get("instillationRequired")
        contractTechnicalRequirenments = try row.get("contractTechnicalRequirenments")
        contractDescription = try row.get("contractDescription")

    }
}


extension Contracts: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { contracts in
            contracts.id()
            contracts.string("contractName")
            contracts.date("contractDeliveryDate")
            contracts.string("contractLocation")
            contracts.bool("instillationRequired")
            contracts.string("contractTechnicalRequirenments")
            contracts.string("contractDescription")
        }
    }
    
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
