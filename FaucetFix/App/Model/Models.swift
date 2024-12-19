import Foundation
import UIKit

struct Order: Identifiable, Codable {
    let id: UUID
    
    var clientName: String
    var date: Date
    var time: Date
    var address: String
    var phoneNumber: String
    var description: String
    
    init(id: UUID = UUID(), clientName: String, date: Date, time: Date, address: String, phoneNumber: String, description: String) {
        self.id = id
        
        self.clientName = clientName
        self.date = date
        self.time = time
        self.address = address
        self.phoneNumber = phoneNumber
        self.description = description
    }
}

struct Stock: Identifiable, Codable {
    let id: UUID
    
    var category: String
    var name: String
    var quantity: Int

    
    init(id: UUID = UUID(), category: String, name: String, quantity: Int) {
        self.id = id
        
        self.category = category
        self.name = name
        self.quantity = quantity
    }
}

struct Contact: Identifiable, Codable {
    let id: UUID
    
    var name: String
    var phoneNumber: String
    var email: String
    var address: String
    var description: String
    
    init(id: UUID = UUID(), name: String, phoneNumber: String, email: String, address: String, description: String) {
        self.id = id
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.description = description
    }
}

struct ObjectWithNameOnly: Identifiable, Codable, Hashable {
    let id: UUID
    
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        
        self.name = name
    }
}

struct WorkRecord: Identifiable, Codable {
    let id: UUID
    
    var date: Date
    var clientName: String
    var order: String
    var workingTime: String
    var materials: [ObjectWithNameOnly]
    var description: String
    var workImage: UIImageData? = nil
    
    init(id: UUID = UUID(), date: Date, clientName: String, order: String, workingTime: String, materials: [ObjectWithNameOnly], description: String, workImage: UIImageData? = nil) {
        self.id = id
        
        self.date = date
        self.clientName = clientName
        self.order = order
        self.workingTime = workingTime
        self.materials = materials
        self.description = description
        self.workImage = workImage
        
    }
}

struct UIImageData: Codable {
    var imageData: Data
    
    init(from image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
    }
    
    func toUIImage() -> UIImage? {
        return UIImage(data: imageData)
    }
}



