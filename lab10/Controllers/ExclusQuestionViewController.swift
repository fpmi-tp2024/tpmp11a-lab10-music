import Foundation
import UIKit

class ExclusQuestionViewController: UIViewController {
    @IBOutlet weak var messageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendOnlineAction(_ sender: Any) {
        if messageText.text != "" {
            ShowInfolWindow.shared.short(self.view, txt_msg: "Наши специалисты свяжутся с вами в билжайшее время! Спасибо за обращение, " + UserDefaults.standard.string(forKey: "Login")!)
            sendStringToServer(string: messageText.text!)
            
        }
        else {
            ShowInfolWindow.shared.short(self.view, txt_msg: "Пожалуйста, введите ваш вопрос")
        }
    }
    
    @IBAction func backFromOnlineAction(_ sender: Any) {
        self.performSegue(withIdentifier: "allquestStions", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func sendStringToServer(string: String) {
        let urlString = "http://178.127.22.144:8080";
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = ["data": string]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            print("Error creating JSON data")
            return
        }

        request.httpBody = httpBody

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
            }
        }

        task.resume()
    }
}
