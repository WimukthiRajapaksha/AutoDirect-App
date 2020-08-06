//
//  VehicleModelInDetail.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class VehicleModelInDetail {
    private let autoId: Int
    private let id: Int?
    private let title: String
    private let conditions: String
    private let bodies: String
    private let makes: String
    private let models: String
    private let mileages: String
    private let fuelTypes: String
    private let engines: String
    private let years: Int
    private let rentals: String
    private let fuelConsumptions: String
    private let transmission: String
    private let drives: String
    private let fuelEconomy: String
    private let exteriorColors: String
    private let interiorColors: String
    private let availabilities: String
    private let additionalFeatures: String
    private let prominentWords: String
    private let quotation: String
    private let price: Int
    private let downPayment: String
    private let imageURL: String
    private let stockNumber: String
    
    init(autoId: Int, id: Int?, title: String, conditions: String, bodies: String, makes: String, models: String, mileages: String, fuelTypes: String, engines: String, years: Int, rentals: String, fuelConsumptions: String, transmission: String, drives: String, fuelEconomy: String, exteriorColors: String, interiorColors: String, availabilities: String, additionalFeatures: String, prominentWords: String, quotation: String, price: Int, downPayment: String, imageURL: String, stockNumber: String) {
        self.autoId = autoId
        self.id = id
        self.title = title
        self.conditions = conditions
        self.bodies = bodies
        self.makes = makes
        self.models = models
        self.mileages = mileages
        self.fuelTypes = fuelTypes
        self.engines = engines
        self.years = years
        self.rentals = rentals
        self.fuelConsumptions = fuelConsumptions
        self.transmission = transmission
        self.drives = drives
        self.fuelEconomy = fuelEconomy
        self.exteriorColors = exteriorColors
        self.interiorColors = interiorColors
        self.availabilities = availabilities
        self.additionalFeatures = additionalFeatures
        self.prominentWords = prominentWords
        self.quotation = quotation
        self.price = price
        self.downPayment = downPayment
        self.imageURL = imageURL
        self.stockNumber = stockNumber
    }
    
    public func getAutoId() -> Int {
        return self.autoId
    }
    
    public func getId() -> Int? {
        return self.id
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getConditions() -> String {
        return self.conditions
    }
    
    public func getBodies() -> String {
        return self.bodies
    }
    
    public func getMakes() -> String {
        return self.makes
    }
    
    public func getModels() -> String {
        return self.models
    }
    
    public func getMileages() -> String {
        return self.mileages
    }
    
    public func getFuelTypes() -> String {
        return self.fuelTypes
    }
    
    public func getEngines() -> String {
        return self.engines
    }
    
    public func getYears() -> Int {
        return self.years
    }
    
    public func getRentals() -> String {
        return self.rentals
    }
    
    public func getFuelConsumptions() -> String {
        return self.fuelConsumptions
    }
    
    public func getTransmission() -> String {
        return self.transmission
    }
    
    public func getDrives() -> String {
        return self.drives
    }
    
    public func getFuelEconomy() -> String {
        return self.fuelEconomy
    }
    
    public func getExteriorColors() -> String {
        return self.exteriorColors
    }
    
    public func getInteriorColors() -> String {
        return self.interiorColors
    }
    
    public func getAvailabilities() -> String {
        return self.availabilities
    }
    
    public func getAdditionalFeatures() -> String {
        return self.additionalFeatures
    }
    
    public func getProminentWords() -> String {
        return self.prominentWords
    }
    
    public func getQuotation() -> String {
        return self.quotation
    }
    
    public func getPrice() -> Int {
        return self.price
    }
    
    public func getDownPayment() -> String {
        return self.downPayment
    }
    
    public func getImageUrl() -> String {
        return self.imageURL
    }
    
    public func getStockNumber() -> String {
        return self.stockNumber
    }
}
