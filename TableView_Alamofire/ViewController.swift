//
//  ViewController.swift
//  TableView_Alamofire
//
//  Created by srinivas on 18/01/18.
//  Copyright © 2018 srinivas. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var countries = [Country]()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getMycountries()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(countries.count)")
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        cell.mylabel.text = self.countries[indexPath.row].name
        
        return cell
    }
    
    func getMycountries(){
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        Alamofire.request(url!).responseJSON { (response) in
            let result = response.data
            do{
                self.countries = try JSONDecoder().decode([Country].self, from: result!)
                // print(self.countries)
                self.tableview.delegate = self
                self.tableview.dataSource = self
                //                for country in self.countries{
                //                    print("\(country.name) , \(country.capital)")
                //                }
            }catch{
                print("error")
            }
        }
    }
 
}

