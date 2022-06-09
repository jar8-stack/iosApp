import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
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
                
                // Guardar sesiòn activa
                
                var json1 = SesionActiva(usuario: Usuario(email: self.emailText))
                
                let path = Bundle.main.path(forResource: "sesionActiva", ofType: "json")
                let url = URL(fileURLWithPath: path!)
                
                URLSession.shared.dataTask(with: url){
                    (data, response, error) in
                    do {
                        if let data = data{
                            var json = try JSONDecoder().decode(SesionActiva.self, from: data)
                            DispatchQueue.main.async {
                                json.usuario.email = json1.usuario.email
                                
                                
                                print()
                            }
                        }else{
                            print("No data")
                        }
                    }catch{
                        print(error)
                    }
                }.resume()
                
                // Guardar sesiòn activa
                
                let menuController = self.storyboard?.instantiateViewController(identifier: "menu_vc") as! MenuViewController
                self.present(menuController, animated: true)
            }else{
                print("Ocurrio un error en el inicio de sesiòn")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    struct SesionActiva: Codable{
        var usuario: Usuario
    }
    
    struct Usuario: Codable{
        var email: String
    }
    
}
