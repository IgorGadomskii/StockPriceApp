
struct Stock: Codable {
    
    var symbol: String!
    var name: String!
    var price: Int!
    var exchange: Int!
    
   
    
    init(stocksData: [String : Any]) {
        symbol = stocksData["symbol"] as? String
        name = stocksData["name"] as? String
        price = stocksData["price"] as? Int
        exchange = stocksData["exchange"] as? Int
    }
    
    static func getStocks(from value: Any) -> [Stock] {
        guard let stockData = value as? [[String : Any]] else {return []}
        return stockData.compactMap { Stock(stocksData: $0)}
        
    }
}

struct Section {
    var title: String!
    var stocks: [Stock]
}


