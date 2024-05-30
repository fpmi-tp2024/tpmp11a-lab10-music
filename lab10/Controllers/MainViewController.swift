import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var ask1: UILabel!
    @IBOutlet weak var ask2: UILabel!
    @IBOutlet weak var wordsInput: UITextField!
    var resQuest = [UILabel]()
    var data = [String]()
    
    func setupData() -> [String]
    {
        let path = Bundle.main.path(forResource: "Questions", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        return dict!.object(forKey: "Questions") as! [String]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resQuest = [ask1, ask2]
        data = setupData()
    }
    
    @IBAction func findSimilarQuestionsAction(_ sender: Any) {
        if (wordsInput.text != "") {
            let inpTexts = wordsInput.text?.split{$0 == " "}.map(String.init)
            resQuest[0].text = ""
            resQuest[1].text = ""
            var filledLabel = 0
            forMet: for i in 0..<data.count {
                for j in 0..<inpTexts!.count {
                    if ((data[i].range(of:inpTexts![j]) != nil) || (data[i].lowercased().range(of:inpTexts![j]) != nil)) {
                        resQuest[filledLabel].text = data[i]
                        filledLabel += 1
                        if (filledLabel > 1) {
                            break forMet
                        }
                        break
                    }
                }
            }
            if (filledLabel == 0) {
                ask1.text = "Совпадений не найдено"
            }
        }
        else {
            ShowInfolWindow.shared.short(self.view, txt_msg: "Пожалуйста, введите ключевые слова")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
