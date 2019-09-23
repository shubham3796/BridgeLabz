
import UIKit

class ViewController: UIViewController {

    var cardTextArray = ["👻","🤡"]
    //var cardButtonArray = [UIButton]()
    var flipCount = 0
    
    @IBOutlet weak var flipCountlabel: UILabel!
    //flipCountlabel.text = "Flip Count : 0"
    
    func flipCard(number index:Int ,on sender: UIButton) {
        if sender.currentTitle == "" {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.5235923947, blue: 0.07331485632, alpha: 1)
            sender.setTitle(cardTextArray[index], for: .normal)
            print("\(flipCount)")
            flipCountlabel.text = "Flip Count : \(flipCount)"
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sender.setTitle("", for: .normal)
            print("\(flipCount)")
            flipCountlabel.text = "Flip Count : \(flipCount)"
        }
    }
    
    @IBAction func doOnClick2(_ sender: UIButton) {
        flipCount += 1
        flipCard(number:1 ,on:sender)
    }
    @IBAction func doOnClick(_ sender: UIButton) {
        flipCount += 1
        flipCard(number:0, on:sender)
    }
}

