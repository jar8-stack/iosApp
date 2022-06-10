//
//  EspecificProductViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import UIKit
import Alamofire

class EspecificProductViewController: UIViewController {
    var products:productStats?
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productStock: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    
    @IBAction func sumar(_ sender: Any) {
        cantidad.text = String((Int(cantidad.text!) ?? -1) + 1)
    }
    @IBAction func hacerPedido(_ sender: Any) {
        let date = NSDate()
        let calendar = NSCalendar.current
        let parameters: [String: Any]  = [
            "id_pedidos": Int.random(in: 0..<10000),
            "cantidad" : cantidad.text,
            "direccion_envio" : "calle olmo",
            "fecha_pedido" : "2022-06-09",
            "status_pedido": "abierto",
            "id_usuario": 1
        ]
        
        AF.request("http://localhost:3000/Pedido", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
            }
        
        
        
        let menuController = self.storyboard?.instantiateViewController(identifier: "menu_vc") as! MenuViewController
        self.present(menuController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let someFloat: Float = products?.precio ?? -1.0
        let floatToString: String = String(format: "%.01f", someFloat)
        productPrice.text = floatToString
        productName.text = products?.nombre
        productDescription.text = products?.descripcion
        productImage.load(urlString: products?.url_foto ?? "")
        let x : Int = products?.stock ?? -1
        var myString = String(x)
        productStock.text = myString
    }
    

  

}
