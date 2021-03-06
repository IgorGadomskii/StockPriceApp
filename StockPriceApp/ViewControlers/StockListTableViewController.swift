

import UIKit

class StockListTableViewController: UITableViewController {
    
    var stocks: [Stock] = []
    var sections: [Section] = []
    
    var alphabet: [String] {
        let data = Data()
        let letters = data.alphabet
        return letters
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getStocksInfo()
        addSections()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].stocks.count
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockInfo", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = sections[indexPath.section].stocks[indexPath.row].symbol
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    private func addSections() {
        
        for letter in alphabet {
            var sections = Section(title: letter, stocks: [])
            for stock in stocks {
                if stock.name.starts(with: letter) {
                    sections.stocks.append(stock)
                }
            }
        }
    }
    
    private func getStocksInfo() {
        NetworkManager.shared.fetchData(NetworkManager.shared.stockUrl) {result in
            switch result{
            case .success(let stocks):
                self.stocks = stocks.sorted(by: {$0.symbol < $1.symbol})
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation


*/
}
