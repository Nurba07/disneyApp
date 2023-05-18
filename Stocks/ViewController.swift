//
//  ViewController.swift
//  Stocks
//
//  Created by Nurbakhyt on 05.05.2023.
//  For IT Step 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let baseUrl = "https://api.disneyapi.dev"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockTableViewCell.nib, forCellReuseIdentifier: StockTableViewCell.identifier)
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        let url = URL(string: baseUrl)
        
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let disney = try? JSONDecoder().decode(Disney.self, from: data) {
                    print(disney)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier) as! StockTableViewCell
        cell.nameLabel.text = "Herald"
        return cell
    }
    
}
