
import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURl
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let stockUrl = "https://raw.githubusercontent.com/Real-time-finance/finance-websocket-API/master/companies_list.json"
    
    func fetchData(_ url: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON {
                dataResponse in
                        switch dataResponse.result {
                        case .success(let value):
                            let stock = Stock.getStocks(from: value)
                            DispatchQueue.main.async {
                                completion(.success(stock))
                            }
                        case .failure:
                            completion(.failure(.decodingError))
                        }
            }
        
    }
    

}



