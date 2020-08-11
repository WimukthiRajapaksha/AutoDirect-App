//
//  Domain.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage

class Domain {
    private let getSearch: String
    private let getFindByMake: String
    private let getFindByCondition: String
    private let getFindByYear: String
    private let getFindByModel: String
    private let getTrendingModels: String
    private let getAllMake: String
    private let getModelByMake: String
    private let getTextSearch: String
    private let getAllVehicles: String
    
    private var formatterUtil: FormatterUtil!
    
    
    init?() {
//        "name": "search",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/search/Pre-Owned/BMW/3-series/2013/100/90000",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": ""
//        },
//        "response": []
        self.getSearch = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/search"
        
//        "name": "find-by-make",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-make/Audi",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": "backend api"
//        },
//        "response": []
        self.getFindByMake = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-make"
        
//        "name": "find-by-condition",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-condition/GOV Permit",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": "backend api"
//        },
//        "response": []
        self.getFindByCondition = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-condition"
        
//        "name": "find-by-year",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-year/2020",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": "backend api"
//        },
//        "response": []
        self.getFindByYear = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-year"
        
//        "name": "find-by-model",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-year/2020",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": "backend api"
//        },
//        "response": []
        self.getFindByModel = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/find-by-model"
        
//        "name": "get-trending-models",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/model-list/trending",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": ""
//        },
//        "response": []
        self.getTrendingModels = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/model-list/trending"
        
//        "name": "get-all-make",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/make-list/get",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": ""
//        },
//        "response": []
        self.getAllMake = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/make-list/get"
        
//        "name": "get-models-by-make",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/model-by-make/get/Toyota",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": ""
//        },
//        "response": []
        self.getModelByMake = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/model-by-make/get"
        
//        "name": "text-search",
//        "request": {
//            "url": "ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/text-search/Prius",
//            "method": "GET",
//            "header": [],
//            "body": {},
//            "description": ""
//        },
//        "response": []
        self.getTextSearch = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/text-search"
        
        self.getAllVehicles = "http://ec2-52-77-253-201.ap-southeast-1.compute.amazonaws.com:8080/api/vehicle-all/get"
    }
    
    public func errorMsgJson() -> JSON {
        return JSON(["message", "Error Occurred"])
    }
    
    public func getTrendingVehicleModels(completion: @escaping (Bool, JSON) -> ()) {
        AF.request(
            self.getTrendingModels,
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getAllMakes(completion: @escaping (Bool, JSON) -> ()) {
        AF.request(
            self.getAllMake,
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getModelsByMake(make: String, completion: @escaping (Bool, JSON) -> ()) {
        let make = make.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getModelByMake)/\(make!)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getFindByMake(make: String, completion: @escaping (Bool, JSON) -> ()) {
        let make = make.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getFindByMake)/\(make!)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getFindByModel(model: String, completion: @escaping (Bool, JSON) -> ()) {
        let model = model.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getFindByModel)/\(model!)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getFindByCondition(condition: String, completion: @escaping (Bool, JSON) -> ()) {
        let condition = condition.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getFindByCondition)/\(condition!)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getTextSearch(text: String, completion: @escaping (Bool, JSON) -> ()) {
        let condition = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getTextSearch)/\(condition!)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getSearch(searchDetails: SearchVehicles, completion: @escaping (Bool, JSON) -> ()) {
        let condition = searchDetails.condition.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let make = searchDetails.make.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let model = searchDetails.model.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        AF.request(
            "\(self.getSearch)/\(condition!)/\(make!)/\(model!)/\(searchDetails.year)/\(searchDetails.minPrice)/\(searchDetails.maxPrice)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func getAllVehicles(completion: @escaping (Bool, JSON) -> ()) {
        AF.request(
            "\(self.getAllVehicles)",
            method: .get,
            parameters: .none,
            encoding: JSONEncoding.default,
            headers: .none
        ).responseJSON { (response) in
            switch (response.result) {
                case .success(_):
                    let respo = FormatterUtil(responseCode: response.response!.statusCode, dataBody: response.data)
                    completion(respo.getFormattedResponse().0, respo.getFormattedResponse().1)
                case .failure(_):
                    completion(false, self.errorMsgJson())
            }
        }
    }
    
    public func loadImage(url: String, completion: @escaping (Bool, Data) -> ()) {
        AF.request(url).responseImage { (response) in
            if response.error == nil {
                completion(true, response.data!)
            } else {
                completion(false, Data())
            }
        }
    }
}
