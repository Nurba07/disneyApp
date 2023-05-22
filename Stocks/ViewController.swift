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
    
    var searchActive: Bool = false
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var character: [GetData] = [GetData]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var filteredCharacter: [GetData] = [GetData]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lazy var searchBar: UISearchBar = UISearchBar(frame: CGRectMake(0, 0, view.frame.width, 20))

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(StockTableViewCell.nib, forCellReuseIdentifier: StockTableViewCell.identifier)
        searchBar.placeholder = "texttest"
        var leftBar = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = leftBar
        self.filteredCharacter = character

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

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter: Int
        if(searchActive){
            counter = filteredCharacter.count
        }else {
            counter = character.count

        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier) as! StockTableViewCell
        if (searchActive == true) {
            cell.nameLabel.text = filteredCharacter[indexPath.row].name
            let url = URL(string: filteredCharacter[indexPath.row].imageUrl)
            cell.characterImage.kf.setImage(with: url)
        } else {
            cell.nameLabel.text = character[indexPath.row].name
            let url = URL(string: character[indexPath.row].imageUrl)
            cell.characterImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCharacter = character.filter { $0.name == searchText }
        print(self.filteredCharacter.count)
        if(filteredCharacter.count == 0){
            self.searchActive = false
        }else{
            self.searchActive = true
        }
        self.tableView.reloadData()
    }


}
