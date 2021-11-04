
import Foundation

struct userAddressDC : Codable {
    
	let status : Int?
	let data : AddressData?
	let messages : String?
}

struct AddressData : Codable {
    
    let address : [Address]?
}

struct Address : Codable {
    
    let id : String?
    let name : String?
    let phone : String?
    let flatno : String?
    let building : String?
    let streetaddress : String?
    let area : String?
    let city : String?
    let state : String?
    let country : String?
    let latitude : String?
    let longitude : String?
}
