import Foundation
import Alamofire
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ConsommationViewModel()
    @State private var selectedDate = Date()
    @State private var energyConsumption: Double = 0.0
    @State private var transportEmissions: Double = 0.0
    @State private var wasteEmissions: Double = 0.0
    @State private var isShareSheetPresented = false
    @State private var isRefreshing = false

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    var totalEmissions: Double {
        return viewModel.totalForDay
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()

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

                    Text("Énergie: \(String(format: "%.2f", energyConsumption)) kg CO2")
                        .padding()

                    Text("Transport: \(String(format: "%.2f", viewModel.transportEmissions)) kg CO2")
                        .padding()

                    Text("Déchets: \(String(format: "%.2f", viewModel.wasteEmissions)) kg CO2")
                        .padding()

                    // Block of text with carbon footprint information
                    Text("L'empreinte carbone mesure la quantité totale de gaz à effet de serre, exprimée en équivalent CO2, émise directement ou indirectement par une activité, un individu, une organisation ou un produit.")
                        .font(.body)
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)

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

                    Spacer()
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                // Fetch initial data when the view appears
                self.refreshData()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    var shareableContent: String {
        """
        Date: \(formattedDate)
        Total empreinte: \(String(format: "%.2f", totalEmissions)) kg CO2
        Énergie: \(String(format: "%.2f", energyConsumption)) kg CO2
        Transport: \(String(format: "%.2f", viewModel.transportEmissions)) kg CO2
        Déchets: \(String(format: "%.2f", viewModel.wasteEmissions)) kg CO2
        """
    }

    private func refreshData() {
        isRefreshing = true

        let types = ["Waste", "Transport", "Domestique"]

        for type in types {
            viewModel.calculateTotalByType(type: type) { result in
                switch result {
                case .success(let total):
                    // Update the appropriate values in your model or elsewhere
                    if type == "Waste" {
                        self.viewModel.wasteEmissions = total
                    } else if type == "Transport" {
                        self.viewModel.transportEmissions = total
                    } else if type == "Domestique" {
                        self.energyConsumption = total
                        self.viewModel.energyConsumption = total
                    }

                    // Imprimez pour vous assurer que les valeurs sont correctes
                    print("\(type) total: \(total)")

                    self.refreshTotalEmissions()
                case .failure(let error):
                    print("Error calculating total for \(type): \(error)")
                    self.isRefreshing = false
                }
            }
        }

        viewModel.calculateTotalForDay { result in
            switch result {
            case .success(let totalForDay):
                print("Total empreinte for the day: \(totalForDay)")

                viewModel.totalForDay = totalForDay
            case .failure(let error):
                print("Error calculating total for the day: \(error)")
            }

            self.isRefreshing = false
        }
    }

    private func refreshTotalEmissions() {
        viewModel.objectWillChange.send()
        print("--------------------------------")
    }
}

struct BarChartView: View {
    let percentages: [Double]
    let labels: [String]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<percentages.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: 40, height: CGFloat(percentages[index]) * 100, alignment: .bottom)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
