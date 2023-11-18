//
//  ConsomamtionViewModel.swift
//  ProjetMobile
//
//  Created by iMac on 15/11/2023.
//

import Foundation
import Alamofire
import SwiftUI

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

class ConsommationViewModel: ObservableObject {
    @Published var consommation: Consommation?
    @Published var totalForDay: Double = 0.0
    @Published var totalByType: Double = 0.0

    @Published var energyConsumption: Double = 0.0
    @Published var transportEmissions: Double = 0.0
    @Published var wasteEmissions: Double = 0.0
    
    var emissionPercentages: [Double] {
        let total = totalForDay
        let energyPercentage = energyConsumption / total
        let transportPercentage = transportEmissions / total
        let wastePercentage = wasteEmissions / total

        return [energyPercentage, transportPercentage, wastePercentage]
    }

    func saveToDatabase(type: String, valeur: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "http://192.168.224.223:8000/consom/add"
        
        let parameters: [String: Any] = [
            "type": type,
            "valeur": valeur
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func calculateTotalByType(type: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let endpoint = "http://192.168.224.223:8000/consom/totalType"

        let parameters: [String: Any] = [
            "type": type
        ]

        AF.request(endpoint, method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Double.self) { response in
                switch response.result {
                case .success(let total):
                    // Mettez à jour les propriétés appropriées
                    if type.lowercased() == "waste" {
                        self.wasteEmissions = total
                    } else if type.lowercased() == "Transport" {
                        self.transportEmissions = total
                    } else if type.lowercased() == "Domestique" {
                        self.energyConsumption = total
                    }

                    // Imprimez le total pour vous assurer qu'il est correct
                    print("\(type) total: \(total)")

                    completion(.success(total))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

        func calculateTotalForDay(completion: @escaping (Result<Double, Error>) -> Void) {
            let endpoint = "http://192.168.224.223:8000/consom/total"

            AF.request(endpoint, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: [String: Double].self) { response in
                    switch response.result {
                    case .success(let result):
                        if let total = result["total"] {
                            completion(.success(total))
                        } else {
                            let error = NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Key 'total' not found in the response"])
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }

  /*  static func calculateTotalForDay( completion: @escaping (Result<Double, Error>) -> Void) {
        let endpoint = "https://192.168.161.223:8000/consom/total"

       

        AF.request(endpoint, method: .get, encoding: <#T##ParameterEncoding#>)
            .validate()
            .responseDecodable(of: Double.self) { response in
                switch response.result {
                case .success(let total):
                    completion(.success(total))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
    */
    
    
   /* func createConsommation(type: String, valeur: Double) {
        let consommation = Consommation(type: type, valeur: valeur)

        consommation.saveToDatabase(completion: <#T##(Result<Consommation, Error>) -> Void#>) { result in
            switch result {
            case .success(let createdConsommation):
                DispatchQueue.main.async {
                    self.consommation = createdConsommation
                }
            case .failure(let error):
                print("Error creating consommation: \(error)")
            }
        }
    }

    func calculateTotalForDay(startOfDay: Date, endOfDay: Date) {
        Consommation.calculateTotalForDay(startOfDay: startOfDay, endOfDay: endOfDay) { result in
            switch result {
            case .success(let total):
                DispatchQueue.main.async {
                    self.totalForDay = total
                }
            case .failure(let error):
                print("Error calculating total for the day: \(error)")
            }
        }
    }

    func calculateTotalByType(type: String) {
        Consommation.calculateTotalByType(type: type) { result in
            switch result {
            case .success(let total):
                DispatchQueue.main.async {
                    self.totalByType = total
                }
            case .failure(let error):
                print("Error calculating total for type \(type): \(error)")
            }
        }
    }*/


