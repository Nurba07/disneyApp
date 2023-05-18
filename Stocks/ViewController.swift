//
//  ViewController.swift
//  Stocks
//
//  Created by Nurbakhyt on 05.05.2023.
//  For IT Step 

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseUrl = "https://api.disneyapi.dev/character"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var character: [GetData] = [GetData]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockTableViewCell.nib, forCellReuseIdentifier: StockTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        let url = URL(string: baseUrl)
        
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let disney = try? JSONDecoder().decode(Disney.self, from: data) {
                    self.character = disney.data
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error.localizedDescription)")
            }
        }
        task.resume()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier) as! StockTableViewCell
        cell.nameLabel.text = character[indexPath.row].name
        let url = URL(string: character[indexPath.row].imageUrl)
        print(url)
        cell.characterImage.kf.setImage(with: url)
        return cell
    }
    
}
