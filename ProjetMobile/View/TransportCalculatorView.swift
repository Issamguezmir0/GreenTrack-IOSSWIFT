//
//  TransportCalculatorView.swift
//  ProjetMobile
//
//  Created by atef on 7/11/2023.
//

import SwiftUI

struct TransportCalculatorView: View {
    @State private var distance: Double = 0
    @State private var selectedTransportMode: String = "Car"
    @State private var selectedDurationIndex = 0
    let transportModes = ["Car", "Bike", "Public Transport", "Walking", "Motorcycle"]
    let durations = ["1 jour", "1 semaine", "1 mois", "6 mois", "1 an"]
    let daysInMonth: Double = 30.44 // Moyenne de jours dans un mois
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Transport")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Text("Distance parcourue (km) :")
                    TextField("Entrez la distance", text: Binding<String>(
                        get: { String(format: "%.2f", distance) },
                        set: {
                            if let value = NumberFormatter().number(from: $0) {
                                distance = value.doubleValue
                            }
                        }
                    ))
                   // .keyboardType(.decimalPad) // Permet d'entrer uniquement des chiffres décimaux
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(10)
                }
                .padding()
                
                Picker("Mode de transport :", selection: $selectedTransportMode) {
                    ForEach(transportModes, id: \.self) {
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
                
                
                Image("transport") // Utilisez le nom du fichier d'image sans l'extension
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                 .frame(width: 250, height: 250)
                    .padding()
              //  Image(systemName: "bolt.car")
                 //   .resizable()
                 //   .aspectRatio(contentMode: .fit)
                  //  .padding(.vertical, 50)
                
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
          //  .background(
             //   LinearGradient(gradient: Gradient(colors: [Color.gray, Color.green]), startPoint: .top, endPoint: .bottom)
                  //  .edgesIgnoringSafeArea(.all)
       //     )
          //  .navigationBarTitle(Text("Calculateur d'Empreinte Carbone - Transport"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
    
    func calculateCarbonFootprint() -> Double {
        var carbonFootprint = 0.0
        
        // Calcul basique de l'empreinte carbone
        let daysInSelectedDuration = getDaysInSelectedDuration()
        carbonFootprint += distance * 0.2 * daysInSelectedDuration // Valeur arbitraire pour les émissions de CO2 par kilomètre
        
        // Facteurs de conversion en fonction du mode de transport
        switch selectedTransportMode {
        case "Car":
            carbonFootprint *= 1.5 // Augmentation de 50% pour les voitures
        case "Bike":
            carbonFootprint *= 0.1 // Réduction de 90% pour les vélos
        case "Public Transport":
            carbonFootprint *= 1.2 // Augmentation de 20% pour les transports en commun
        case "Walking":
            carbonFootprint *= 0.05 // Réduction de 95% pour la marche à pied
        case "Motorcycle":
            carbonFootprint *= 1.8 // Augmentation de 80% pour les motos
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

struct TransportCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TransportCalculatorView()
    }
}

