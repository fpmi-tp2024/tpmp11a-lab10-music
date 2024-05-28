import UIKit

class ExclusQuestionViewController: UIViewController {
    @IBOutlet weak var messageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendOnlineAction(_ sender: Any) {
        if messageText.text != "" {
            ShowInfolWindow.shared.short(self.view, txt_msg: "Наши специалисты свяжутся с вами в билжайшее время! Спасибо за обращение, " + UserDefaults.standard.string(forKey: "Login")!)
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
}
