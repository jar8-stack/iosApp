//
//  DetallePedidoViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import UIKit

class DetallePedidoViewController: UIViewController {
    
    var detalle: detallePedido?
    
    @IBOutlet weak var cant: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var direccion: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x : Int = detalle?.cantidad ?? -1
        var myString = String(x)
        cant.text = myString
        fecha.text = detalle?.fecha_pedido
        direccion.text = detalle?.direccion_envio
    }
    
    
    struct detallePedido: Codable{
        var id_pedido: Int
        var cantidad: Int
        var direccion_envio: String
        var fecha_pedido: String
    }

}
