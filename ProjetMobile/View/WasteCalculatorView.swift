//
//  WasteCalculatorView.swift
//  ProjetMobile
//
//  Created by atef on 7/11/2023.
//

import SwiftUI

struct WasteCalculatorView: View {
    @State private var wasteWeight: Double = 0
    @State private var selectedWasteType: String = "General"
    let wasteTypes = ["General", "Recyclable", "Organic", "Hazardous"]
    let daysInMonth: Double = 30.44 // Moyenne de jours dans un mois

    var body: some View {
        NavigationStack {
            VStack {
                Text(" Déchets")
                    .font(.largeTitle)
                    .padding()

                HStack {
                    Text("Poids des déchets (kg) :")
                    TextField("Entrez le poids", text: Binding<String>(
                        get: { String(format: "%.2f", wasteWeight) },
                        set: {
                            if let value = NumberFormatter().number(from: $0) {
                                wasteWeight = value.doubleValue
                            }
                        }
                    ))
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(10)
                }
                .padding()

                Picker("Type de déchets :", selection: $selectedWasteType) {
                    ForEach(wasteTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white.opacity(0.4))
                .cornerRadius(10)

                Image("trash") // Utilisez le nom du fichier d'image sans l'extension
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding()

                Spacer()

                Text("Votre empreinte carbone : \(calculateCarbonFootprint()) kg CO2")
                    .font(.headline)
                    .padding()

                HStack {
                    NavigationLink(destination: ContentView()) {
                        Text("Back")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        // Enregistrez le calcul dans la base de données ici
                        createConsommation()

                        // Remettez les valeurs à zéro
                        resetValues()
                    }) {
                        Text("Save")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                
                }
                .padding()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }

    func calculateCarbonFootprint() -> Double {
        var carbonFootprint = 0.0

        // Calcul basique de l'empreinte carbone
        carbonFootprint += wasteWeight * 0.1 // Valeur arbitraire pour les émissions de CO2 par kilogramme

        // Facteurs de conversion en fonction du type de déchets
        switch selectedWasteType {
        case "General":
            carbonFootprint *= 1.2 // Augmentation de 20% pour les déchets généraux
        case "Recyclable":
            carbonFootprint *= 0.8 // Réduction de 20% pour les déchets recyclables
        case "Organic":
            carbonFootprint *= 0.5 // Réduction de 50% pour les déchets organiques
        case "Hazardous":
            carbonFootprint *= 1.5 // Augmentation de 50% pour les déchets dangereux
        default:
            break
        }

        return carbonFootprint
    }

    func createConsommation() {
       
        
        
        
        print("Données enregistrées dans la base de données !")
        
    }

    func resetValues() {
        // Remettez les valeurs à zéro
        wasteWeight = 0
        selectedWasteType = "General"
    }
}

struct WasteCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WasteCalculatorView()
    }
}
