//
//  ListaPedidosViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import UIKit
import Alamofire

class ListaPedidosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listPedidosolo = [listPedidos1]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPedidosolo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalle_segue", sender: self)    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = listPedidosolo[indexPath.row].direccion_envio.capitalized
        return cell
    }
    

    @IBOutlet weak var listPedidos: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPedidos.delegate = self
        listPedidos.dataSource = self
        
        downLoadPedidos {
            self.listPedidos.reloadData()
        }
    }
    
    
    func downLoadPedidos(completed: @escaping () -> ()){
        let request = AF.request("http://localhost:3000/Pedido/1")
        
        request.responseData{ (dataResponse) in
            if let err = dataResponse.error {
                        print("Failed to contact", err)
                        return
                    }
            guard let data = dataResponse.data else { return }
                    //let dummyString = String(data: data, encoding: .utf8)
                    //print(dummyString ?? "")

                    do {
                        let searchResult = try JSONDecoder().decode([listPedidos1].self, from: data)
                        
                        self.listPedidosolo = searchResult
                        
                        DispatchQueue.main.async {
                            completed()
                        }
                                                 
                        
                    } catch let decodeError {
                        print("Failed to decode:", decodeError)
                    }
        }
    }

    struct listPedidos1: Codable {
        var id_pedidos: Int
        var cantidad: Int
        var direccion_envio: String
        var fecha_pedido: String
        var id_usuario: Int
    }

}
