import UIKit
import Alamofire

class RegistroViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var url_foto: UITextField!
    @IBOutlet weak var primerNombre: UITextField!
    @IBOutlet weak var primerApellido: UITextField!
    @IBOutlet weak var segundoApellido: UITextField!
    @IBOutlet weak var direccion: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func registrarse(_ sender: Any) {
        let parameters: [String: Any]  = [
            "email" : email.text!,
            "password" : password.text!,
            "telefono" : telefono.text!,
            "imagen_perfil": url_foto.text!,
            "primer_nombre": primerNombre.text!,
            "apellido_paterno": primerApellido.text!,
            "apellido_materno": segundoApellido.text!,
            "direccion": direccion.text!,
            "codigo_postal": codigoPostal.text!
        ]
        
        AF.request("http://localhost:3000/Usuario", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
            }
        
        
        
        let menuController = self.storyboard?.instantiateViewController(identifier: "menu_vc") as! MenuViewController
        self.present(menuController, animated: true)
        
        }
        
    }
    

