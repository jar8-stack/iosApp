//
//  PerfilViewController.swift
//  exposed_code
//
//  Created by Said Serrano on 09/06/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        email.text = "said@gmail.com"
        telefono.text = "9997645160"
        image.load(urlString: "https://misanimales.com/wp-content/uploads/2022/01/jaiba-arena.jpg")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
