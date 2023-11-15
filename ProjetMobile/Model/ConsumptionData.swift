//
//  ConsumptionData.swift
//  ProjetMobile
//
//  Created by atef on 7/11/2023.
//

import Foundation

struct CarbonFootprintData {
    var selectedDate: Date
    var energyConsumption: Double
    var transportEmissions: Double
    var wasteEmissions: Double

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    var totalEmissions: Double {
        return energyConsumption + transportEmissions + wasteEmissions
    }

    var shareableContent: String {
        """
        Date: \(formattedDate)
        Total empreinte: \(String(format: "%.2f", totalEmissions)) kg CO2
        Énergie: \(String(format: "%.2f", energyConsumption)) kg CO2
        Transport: \(String(format: "%.2f", transportEmissions)) kg CO2
        Déchets: \(String(format: "%.2f", wasteEmissions)) kg CO2
        """
    }
}
