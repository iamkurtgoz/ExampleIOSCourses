import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textNumber1: UITextField!
    @IBOutlet weak var textNumber2: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    var number1 = -1, number2 = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        number1 = -1;
        number2 = -1;
    }

    @IBAction func btnTopla(_ sender: Any) {
        if getNumberValues() {
            lblResult.text = "Sonuç : " + String(number1 + number2);
        } else {
            lblResult.text = "İçerik yada içerikler sayı değil.";
        }
    }
    
    @IBAction func btnCikar(_ sender: Any) {
        if getNumberValues() {
            lblResult.text = "Sonuç : " + String(number1 - number2);
        } else {
            lblResult.text = "İçerik yada içerikler sayı değil.";
        }
    }
    @IBAction func btnCarp(_ sender: Any) {
        if getNumberValues() {
            lblResult.text = "Sonuç : " + String(number1 * number2);
        } else {
            lblResult.text = "İçerik yada içerikler sayı değil.";
        }
    }
    @IBAction func btnBol(_ sender: Any) {
        if getNumberValues() {
            lblResult.text = "Sonuç : " + String(number1 / number2);
        } else {
            lblResult.text = "İçerik yada içerikler sayı değil.";
        }
    }
    
    
    private func getNumberValues() -> Bool{
        var isActive = false;
        if let value1 = Int(textNumber1.text!) {
            if let value2 = Int(textNumber2.text!){
                isActive = true;
                number1 = value1;
                number2 = value2;
            } else {
                isActive = false;
            }
        } else {
            isActive = false;
        }
        return isActive;
    }
}

