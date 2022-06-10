//
//  ProductViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import UIKit
import Alamofire


class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = products[indexPath.row].nombre.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalle_segue", sender: self)	
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
        EspecificProductViewController{
            destination.products = products[(listPorducts.indexPathForSelectedRow?.row)!]
        }
    }
    
    @IBOutlet weak var nombreCategoria: UILabel!
    @IBOutlet weak var listPorducts: UITableView!
    
    var products = [productStats]()
    
    var category:categoryStats?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPorducts.delegate = self
        listPorducts.dataSource = self
        
        downloadProducts {
            self.listPorducts.reloadData()
        }
        
        nombreCategoria.text = category?.nombre
        
        
    }
    
    
    
    func downloadProducts (completed: @escaping () -> ()){
        
        let aString = category?.nombre ?? "Comida%20veracruzana"
        let newString = aString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let request = AF.request("http://localhost:3000/ProductoCategoria/\(newString)")
        
        
        
        request.responseData{ (dataResponse) in
            if let err = dataResponse.error {
                        print("Failed to contact", err)
                        return
                    }
            guard let data = dataResponse.data else { return }
                    //let dummyString = String(data: data, encoding: .utf8)
                    //print(dummyString ?? "")

                    do {
                        let searchResult = try JSONDecoder().decode([productStats].self, from: data)
                        
                        self.products = searchResult
                        
                        DispatchQueue.main.async {
                            completed()
                        }
                                                 
                        
                    } catch let decodeError {
                        print("Failed to decode:", decodeError)
                    }
        }
        
    }
}
