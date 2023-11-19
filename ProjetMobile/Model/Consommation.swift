struct ConsommationsData: Decodable {
    let value: Double?
    
    enum CodingKeys: String, CodingKey {
        case value
    }
}

struct Consommation: Decodable {
    var type: String?
    var valeur: Double?
    
    enum CodingKeys: String, CodingKey {
        case type, valeur
    }
}

