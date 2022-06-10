//
//  productStats.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import Foundation


struct productStats: Codable{
    let id_producto: Int
    let nombre: String
    let precio: Float
    let descripcion: String
    let url_foto: String
    let fecha_subida: String
    let stock: Int
}
