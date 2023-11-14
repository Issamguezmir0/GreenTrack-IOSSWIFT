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
    @State private var selectedDurationIndex = 0
    let wasteTypes = ["General", "Recyclable", "Organic", "Hazardous"]
    let durations = ["1 jour", "1 semaine", "1 mois", "6 mois", "1 an"]
    let daysInMonth: Double = 30.44 // Moyenne de jours dans un mois
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(" Déchets")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Text("Poids des déchets (kg) :")
                    TextField("Entrez le poids" , text: Binding<String>(
                        get: { String(format: "%.2f", wasteWeight) },
                        set: {
                            if let value = NumberFormatter().number(from: $0) {
                                wasteWeight = value.doubleValue
                            }
                        }
                    ))
                //    .keyboardType(.decimalPad) // Permet d'entrer uniquement des chiffres décimaux
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
                
                Picker("Durée :", selection: $selectedDurationIndex) {
                    ForEach(0..<durations.count, id: \.self) {
                        Text(durations[$0])
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
                
                NavigationLink(destination: ContentView()) {
                    Text("Back")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
           // .background(
              //  LinearGradient(gradient: Gradient(colors: [Color.green, Color.red]), startPoint: .top, endPoint: .bottom)
                 //   .edgesIgnoringSafeArea(.all)
          //  )
           // .navigationBarTitle(Text("Calculateur d'Empreinte Carbone - Déchets"), displayMode: .inline)
            
        }.navigationBarBackButtonHidden(true)
    }
    
    func calculateCarbonFootprint() -> Double {
        var carbonFootprint = 0.0
        
        // Calcul basique de l'empreinte carbone
        let daysInSelectedDuration = getDaysInSelectedDuration()
        carbonFootprint += wasteWeight * 0.1 * daysInSelectedDuration // Valeur arbitraire pour les émissions de CO2 par kilogramme
        
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
    
    func getDaysInSelectedDuration() -> Double {
        switch selectedDurationIndex {
        case 0: // 1 jour
            return 1
        case 1: // 1 semaine
            return 7
        case 2: // 1 mois
            return daysInMonth
        case 3: // 6 mois
            return daysInMonth * 6
        case 4: // 1 an
            return daysInMonth * 12
        default:
            return 1
        }
    }
}

struct WasteCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        WasteCalculatorView()
    }
}
