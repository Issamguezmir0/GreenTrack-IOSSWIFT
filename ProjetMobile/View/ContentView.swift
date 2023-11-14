//
//  ContentView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 6/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var energyConsumption: Double = 100
    @State private var transportEmissions: Double = 50
    @State private var wasteEmissions: Double = 30
    @State private var showChartDetails = false // Pour afficher les détails du diagramme
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                BarChartView(values: [energyConsumption, transportEmissions, wasteEmissions], labels: ["Énergie", "Transport", "Déchets"])
                    .frame(height: 200)
                    .padding()
                    .onTapGesture {
                        // Afficher les détails du diagramme
                        showChartDetails.toggle()
                    }
                    .sheet(isPresented: $showChartDetails) {
                        // Afficher les détails du diagramme dans un popup ou une nouvelle vue
                        ChartDetailsView(values: [energyConsumption, transportEmissions, wasteEmissions], labels: ["Énergie", "Transport", "Déchets"])
                    }
                
                HStack(spacing: 20) {
                    NavigationLink(destination: EnergyCalculatorView()) {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                    }
                    
                    NavigationLink(destination: TransportCalculatorView()) {
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                    }
                    
                    NavigationLink(destination: WasteCalculatorView()) {
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
           // .background(
              //  LinearGradient(gradient: Gradient(colors: [Color.green, Color.orange, Color.gray]), startPoint: .top, endPoint: .bottom)
                //    .edgesIgnoringSafeArea(.all)
           // )
         //   .navigationBarTitle(Text("Accueil"), displayMode: .inline)
           // .navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarChartView: View {
    let values: [Double]
    let labels: [String]
    let maxValue: Double
    
    init(values: [Double], labels: [String]) {
        self.values = values
        self.labels = labels
        self.maxValue = values.max() ?? 1 // Éviter la division par zéro
    }
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<values.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 40, height: CGFloat(values[index]) / CGFloat(maxValue) * 100, alignment: .bottom)
                        .foregroundColor(Color.blue)
                    Text(labels[index])
                        .padding(.top, 5)
                }
            }
        }
    }
}

struct ChartDetailsView: View {
    let values: [Double]
    let labels: [String]
    
    var body: some View {
        // Implémentez ici l'affichage des détails du diagramme
        // Peut-être une vue avec des informations détaillées ou un graphique interactif
        //...
        Text("normalemt yo5erjoulou des information 3alla consommation mte3ou houa detailler ")
    }
}
