import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var device = [Device]()
    var usuario = [Usuario]()
    
    
    var emailText: String { // not optional, you give a "" default value if nil
        return email.text ?? ""
    }
    var passText: String { // not optional, you give a "" default value if nil
        return password.text ?? ""
    }
    
    @IBAction func irRegistro(_ sender: Any) {
        let registroController = self.storyboard?.instantiateViewController(identifier: "registro_vc") as! RegistroViewController
        self.present(registroController, animated: true)

    }
    
    
    
  
    
    
    @IBAction func login(_ sender: Any) {
        let request = AF.request("http://localhost:3000/Usuario/\(emailText)")
        
        
        request.responseDecodable(of: User.self) { (response) in
          guard let users = response.value else { return }
            if(users.password == self.passText){
                print("Se ha logueado correctamente")
                
                let menuController = self.storyboard?.instantiateViewController(identifier: "menu_vc") as! MenuViewController
                self.present(menuController, animated: true)
                
                
            }else{
                print("Ocurrio un error en el inicio de sesiòn")
            }
        }
    }
    @IBOutlet weak var imageLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.load(urlString: "https://vangogh.teespring.com/v3/image/moo9Hb8qMIJBwnY4-YuYDzUQdr8/960/1120.jpg")
        
    }
    
    
    
 
struct Response: Codable{
    let results: User
    let status: String
}

struct User: Codable{
    let id_usuario: Int
    let email: String
    let password: String
    let telefono: String
    let imagen_perfil: String
    let primer_nombre: String
    let apellido_paterno: String
    let apellido_materno: String
    let direccion: String
    let codigo_postal: String
}
    
    struct Device: Codable{
        var id_device: Int
        var device_id: String
    }
    
    struct Usuario: Codable{
        var id_usuario: Int
        var email: String
    }
    
}
