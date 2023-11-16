struct ConsommationsData: Decodable {
    let consommations: [Consommation]?
    
    enum CodingKeys: String, CodingKey {
        case consommations = "consommations"
    }
}

struct Consommation: Decodable {
  
    var type: String?
    var valeur: Double?
    
    enum CodingKeys: String, CodingKey {
        case type, valeur
    }
}
