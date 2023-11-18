import SwiftUI

struct EnergyCalculatorView: View {
    @State private var electricityConsumption: Double = 0
    @State private var gasConsumption: Double = 0
    @State private var selectedEnergySource: String = "Renewable"
    @State private var electricityInfoAlert = false
    @State private var gasInfoAlert = false
    
    let energySources = ["Renewable", "Natural Gas", "Coal", "Oil"]
    let daysInMonth: Double = 30.44 // Moyenne de jours dans un mois
    
    var body: some View {
        NavigationView {
            VStack {
                Text(" Énergie Domestique")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Text("Consommation d'électricité (kWh) :")
                    TextField("Entrez la consommation", value: $electricityConsumption, formatter: NumberFormatter())
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)

                    Button(action: {
                        electricityInfoAlert.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .padding(.leading, 5)
                    }
                    .alert(isPresented: $electricityInfoAlert) {
                        Alert(title: Text("Information"),
                              message: Text("La consommation d'électricité représente la quantité d'électricité utilisée en kilowattheures (kWh) pendant la période spécifiée. Utilisez votre facture d'électricité pour obtenir cette information."),
                              dismissButton: .default(Text("OK")))
                    }
                }
                .padding()

                HStack {
                    Text("Consommation de gaz (m³) :")
                    TextField("Entrez la consommation", value: $gasConsumption, formatter: NumberFormatter())
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)

                    Button(action: {
                        gasInfoAlert.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .padding(.leading, 5)
                    }
                    .alert(isPresented: $gasInfoAlert) {
                        Alert(title: Text("Information"),
                              message: Text("La consommation de gaz représente la quantité de gaz naturel utilisée en mètres cubes (m³) pendant la période spécifiée. Utilisez votre facture de gaz pour obtenir cette information."),
                              dismissButton: .default(Text("OK")))
                    }
                }
                .padding()

                Picker("Source d'énergie :", selection: $selectedEnergySource) {
                    ForEach(energySources, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white.opacity(0.4))
                .cornerRadius(10)
                
                Image("domestique")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding()
                Spacer()
                
                Text("Votre empreinte carbone : \(calculateCarbonFootprint()) kg CO2")
                    .font(.headline)
                    .padding(-5)
                
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
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func calculateCarbonFootprint() -> Double {
        var carbonFootprint = 0.0
        
        // Calcul basique de l'empreinte carbone
        carbonFootprint += electricityConsumption * 0.5 // Valeur arbitraire pour l'électricité
        carbonFootprint += gasConsumption * 1.8 // Valeur arbitraire pour le gaz
        
        // Facteurs de conversion en fonction de la source d'énergie
        switch selectedEnergySource {
        case "Renewable":
            carbonFootprint *= 0.5 // Réduction de 50% pour l'énergie renouvelable
        case "Natural Gas":
            carbonFootprint *= 1.2 // Augmentation de 20% pour le gaz naturel
        case "Coal":
            carbonFootprint *= 2.5 // Augmentation de 150% pour le charbon
        case "Oil":
            carbonFootprint *= 2.0 // Augmentation de 100% pour le pétrole
        default:
            break
        }
        
        return carbonFootprint
    }
    
    func saveToDatabase() {
        let type = "Domestique"
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
        electricityConsumption = 0
        gasConsumption = 0
        selectedEnergySource = "Renewable"
    }
}

struct EnergyCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        EnergyCalculatorView()
    }
}
