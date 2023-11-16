//
//  ContentView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 6/11/2023.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State  var energyConsumption: Double = 0.0
    @State  var transportEmissions: Double = 0.0
    @State  var wasteEmissions: Double = 0.0
    @State private var isShareSheetPresented = false
    @State private var isRefreshing = false

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    var totalEmissions: Double {
        return energyConsumption + transportEmissions + wasteEmissions
    }

    var body: some View {
        NavigationView {
            VStack {
                Text(formattedDate)
                    .font(.title)
                    .padding()
                VStack {
                    Text("Total empreinte")
                        .font(.headline)
                        .foregroundColor(Color.green)
                    Text(String(format: "%.2f kg CO2", totalEmissions))
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.green)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        )
                        .cornerRadius(15)
                }
                .padding()

                BarChartView(
                    values: [energyConsumption, transportEmissions, wasteEmissions],
                    labels: ["Énergie", "Transport", "Déchets"]
                )

                Spacer()

                HStack(spacing: 20) {
                    NavigationLink(destination: EnergyCalculatorView()) {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            )
                    }
                    NavigationLink(destination: TransportCalculatorView()) {
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            )
                    }
                    NavigationLink(destination: WasteCalculatorView()) {
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.green)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            )
                    }
                }

                Button(action: {
                    self.isShareSheetPresented.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        )
                }
                .sheet(isPresented: $isShareSheetPresented) {
                    ShareSheet(activityItems: [shareableContent])
                }
                .padding()

                Button(action: {
                    self.refreshData()
                }) {
                    HStack {
                        Image(systemName: isRefreshing ? "arrow.clockwise.circle.fill" : "arrow.clockwise.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.green)
                        Text("Actualiser")
                            .foregroundColor(Color.green)
                            .font(.headline)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    )
                }
                .disabled(isRefreshing)
                .padding()

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
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

    private func refreshData() {
        isRefreshing = true
       
        // Simulate fetching data for "Waste"
        ConsommationViewModel().calculateTotalByType(type: "waste" ) { result in
            switch result {
            case .success(let total):
                self.wasteEmissions = total
            case .failure(let error):
                print("Error calculating total for waste: \(error)")
            }        }

        // Simulate fetching data for "Transport"
        ConsommationViewModel().calculateTotalByType(type: "Transport") { result in
            switch result {
            case .success(let total):
                self.transportEmissions = total
            case .failure(let error):
                print("Error calculating total for Transport: \(error)")
            }
        }

        // Simulate fetching data for "Domestique"
        ConsommationViewModel().calculateTotalByType(type: "Domestique") { result in
            switch result {
            case .success(let total):
                self.energyConsumption = total
            case .failure(let error):
                print("Error calculating total for Domestique: \(error)")
            }
        }

        // Assuming you have a method like this in your ContentView
        self.refreshTotalEmissions()

        isRefreshing = false
    }

    // Add your refreshTotalEmissions method here
    private func refreshTotalEmissions() {
        // Implement your logic to refresh total emissions here
        // This method is just a placeholder, replace it with your actual logic
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
        self.maxValue = values.max() ?? 1
    }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<values.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 40, height: CGFloat(values[index]) / CGFloat(maxValue) * 100, alignment: .bottom)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    Text(labels[index])
                        .padding(.top, 5)
                }
            }
        }
        .padding(.bottom, 10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}
