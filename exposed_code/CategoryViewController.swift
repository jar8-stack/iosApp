//
//  CategoryViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 08/06/22.
//
import UIKit
import Alamofire


extension UIImageView {
    func load(urlString : String){
        guard let url = URL(string: urlString)else{
            return
        }
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    @IBOutlet weak var imagePrueba: UIImageView!
    @IBOutlet weak var listadoCategorias: UITableView!
    @IBOutlet weak var wait: UIActivityIndicatorView!
    
    var categories = [categoryStats]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listadoCategorias.delegate = self
        listadoCategorias.dataSource = self
        
        
        downloadCategories {
            self.listadoCategorias.reloadData()
            //print("Successfull")
        }
        
        
    }
    
    func downloadCategories(completed: @escaping () -> ()){
        let request = AF.request("http://localhost:3000/Categoria")
        
        request.responseData{ (dataResponse) in
            if let err = dataResponse.error {
                        print("Failed to contact", err)
                        return
                    }
            guard let data = dataResponse.data else { return }
                    //let dummyString = String(data: data, encoding: .utf8)
                    //print(dummyString ?? "")

                    do {
                        let searchResult = try JSONDecoder().decode([categoryStats].self, from: data)
                        
                        self.categories = searchResult
                        
                        DispatchQueue.main.async {
                            completed()
                        }
                                                 
                        
                    } catch let decodeError {
                        print("Failed to decode:", decodeError)
                    }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = categories[indexPath.row].nombre.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "product_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductViewController{
            destination.category = categories[(listadoCategorias.indexPathForSelectedRow?.row)!]
        }
    }
}
