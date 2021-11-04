//
//  locationSearchDC.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import Foundation

struct locationSearchDC: Codable {
    
    var results: [locationData]?
    var status: String?
}

struct locationData: Codable {
 
    var formatted_address: String?
    var geometry: Geometry?
    var icon: String?
    var name: String?
    var placeId: String?
    var photos: [Photo]?
    var formatted_phone_number: String?
    var international_phone_number: String?
    var pharmacyImgURL: String?

}

struct Geometry: Codable  {
    var location: Location?
}

struct Location: Codable  {
    var lat: Double?
    var lng: Double?
}

struct Photo: Codable {
    var height: Double?
    var width: Double?
    var photoReference: String?
}
