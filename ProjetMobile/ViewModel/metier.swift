//
//  metier.swift
//  ProjetMobile
//
//  Created by Mac-Mini-2021 on 15/11/2023.
//

import Foundation
import SwiftUI

class CarbonFootprintViewModel: ObservableObject {
    @Published var carbonFootprintData: CarbonFootprintData

    init(carbonFootprintData: CarbonFootprintData) {
        self.carbonFootprintData = carbonFootprintData
    }

    func calculateTotalCarbonFootprint() -> Double {
        return carbonFootprintData.totalEmissions
    }

    func calculateCarbonFootprintForEnergy() -> Double {
        // Logique pour le calcul des émissions liées à l'énergie
        return carbonFootprintData.energyConsumption * 0.5 // Exemple arbitraire
    }

    // Ajoutez d'autres fonctions pour le calcul des empreintes carbone spécifiques (transport, déchets, etc.)

    func saveToDatabase() {
        // Logique pour enregistrer les données dans la base de données
        print("Données enregistrées dans la base de données !")
    }

    func resetValues() {
        // Logique pour remettre les valeurs à zéro
        carbonFootprintData.energyConsumption = 0
        carbonFootprintData.transportEmissions = 0
        carbonFootprintData.wasteEmissions = 0
    }
}
