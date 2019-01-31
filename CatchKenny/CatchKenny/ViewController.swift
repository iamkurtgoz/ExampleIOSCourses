
import UIKit

class ViewController: UIViewController {

    var HIGHT_SCORE:String = "HIGHT_SCORE";
    
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHightScore: UILabel!
    
    @IBOutlet weak var imgKenny1: UIImageView!
    @IBOutlet weak var imgKenny2: UIImageView!
    @IBOutlet weak var imgKenny3: UIImageView!
    @IBOutlet weak var imgKenny4: UIImageView!
    @IBOutlet weak var imgKenny5: UIImageView!
    @IBOutlet weak var imgKenny6: UIImageView!
    @IBOutlet weak var imgKenny7: UIImageView!
    @IBOutlet weak var imgKenny8: UIImageView!
    @IBOutlet weak var imgKenny9: UIImageView!
    @IBOutlet weak var imgKenny10: UIImageView!
    @IBOutlet weak var imgKenny11: UIImageView!
    @IBOutlet weak var imgKenny12: UIImageView!
    
    var score = 0;
    var timer = Timer();
    var counter = 0;
    var kennyArray = [UIImageView]();
    var hideTimer = Timer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecognizers();
        lblScore.text = "Score : " + String(score);
        //Timers
        counter = 30;
        lblRemainingTime.text = String(counter);
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        //arrays
        kennyArray.append(imgKenny1);
        kennyArray.append(imgKenny2);
        kennyArray.append(imgKenny3);
        kennyArray.append(imgKenny4);
        kennyArray.append(imgKenny5);
        kennyArray.append(imgKenny6);
        kennyArray.append(imgKenny7);
        kennyArray.append(imgKenny8);
        kennyArray.append(imgKenny9);
        kennyArray.append(imgKenny10);
        kennyArray.append(imgKenny11);
        kennyArray.append(imgKenny12);
        hideKenny();
        hightScore(score: 0);
    }
    
    private func initRecognizers(){
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore));
        
        imgKenny1.isUserInteractionEnabled = true;
        imgKenny2.isUserInteractionEnabled = true;
        imgKenny3.isUserInteractionEnabled = true;
        imgKenny4.isUserInteractionEnabled = true;
        imgKenny5.isUserInteractionEnabled = true;
        imgKenny6.isUserInteractionEnabled = true;
        imgKenny7.isUserInteractionEnabled = true;
        imgKenny8.isUserInteractionEnabled = true;
        imgKenny9.isUserInteractionEnabled = true;
        imgKenny10.isUserInteractionEnabled = true;
        imgKenny11.isUserInteractionEnabled = true;
        imgKenny12.isUserInteractionEnabled = true;
        
        imgKenny1.addGestureRecognizer(recognizer1);
        imgKenny2.addGestureRecognizer(recognizer2);
        imgKenny3.addGestureRecognizer(recognizer3);
        imgKenny4.addGestureRecognizer(recognizer4);
        imgKenny5.addGestureRecognizer(recognizer5);
        imgKenny6.addGestureRecognizer(recognizer6);
        imgKenny7.addGestureRecognizer(recognizer7);
        imgKenny8.addGestureRecognizer(recognizer8);
        imgKenny9.addGestureRecognizer(recognizer9);
        imgKenny10.addGestureRecognizer(recognizer10);
        imgKenny11.addGestureRecognizer(recognizer11);
        imgKenny12.addGestureRecognizer(recognizer12);
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true;
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)));
        kennyArray[random].isHidden = false;
    }
    
    @objc func increaseScore(){
        score = score + 1;
        lblScore.text = "Score : " + String(score);
        hightScore(score: self.score);
    }
    
    @objc func countDown(){
        counter = counter - 1;
        lblRemainingTime.text = String(counter);
        if  counter == 0 {
            hightScore(score: self.score);
            timer.invalidate();
            hideTimer.invalidate();
            let alert = UIAlertController(title: "Time", message: "Time's Up!", preferredStyle: UIAlertController.Style.alert);
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: {
                (UIAlertAction) in
                self.score = 0;
                self.lblScore.text = "Score = " + String(self.score);
                self.counter = 30;
                self.lblRemainingTime.text = String(self.counter);
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true);
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true);
            })
            alert.addAction(okButton);
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    private func getHightScore() -> Int{
        return UserDefaults.standard.integer(forKey: HIGHT_SCORE);
    }
    
    private func hightScore(score: Int){
        if score > getHightScore() {
            UserDefaults.standard.set(score, forKey: HIGHT_SCORE);
        }
        lblHightScore.text = "Hight Score : " + String(getHightScore());
    }
}

