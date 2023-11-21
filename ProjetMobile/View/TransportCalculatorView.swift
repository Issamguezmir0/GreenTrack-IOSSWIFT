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
    @State private var distanceInfoAlert = false
    @State private var transportModeInfoAlert = false
    
    let transportModes = ["Car", "Bike", "Public Transport", "Walking", "Motorcycle"]
    let daysInMonth: Double = 30.44 // Moyenne de jours dans un mois
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Transport")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Text("Distance traveled (km) :")
                    TextField("Entrez la distance", value: $distance, formatter: NumberFormatter())
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)

                    Button(action: {
                        distanceInfoAlert.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .padding(.leading, 5)
                    }
                    .alert(isPresented: $distanceInfoAlert) {
                        Alert(title: Text("Information"),
                              message: Text("Distance traveled represents the number of kilometers you traveled during the specified time period."),
                              dismissButton: .default(Text("OK")))
                    }
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
                
                Image("transport") // Utilisez le nom du fichier d'image sans l'extension
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding()
                
                Spacer()
                
                Text("Your carbon footprint: \(calculateCarbonFootprint()) kg CO2")
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
                        saveToDatabase()
                        
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
        return 1 // Retourne une valeur par défaut, car la durée a été supprimée
    }
    
    func saveToDatabase() {
        let type = "Transport"
        let valeur = calculateCarbonFootprint()

        ConsommationViewModel().saveToDatabase(type: type, valeur: valeur) { result in
            switch result {
            case .success:
                print("Data saved successfully!")
            case .failure(let error):
                print("Error saving data: \(error)")
            }
        }
    }
    
    func resetValues() {
        // Remettez les valeurs à zéro
        distance = 0
        selectedTransportMode = "Car"
    }
}

struct TransportCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TransportCalculatorView()
    }
}
