
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced = false
    
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            if (displayResultLabel.text?.count)! < 20 {
                if displayResultLabel.text == "0" {
                    displayResultLabel.text = number
                } else {
                    displayResultLabel.text = displayResultLabel.text! + number
                }
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
        
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.orange
        })
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operationWithTwoOperands(operation:(Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+": operationWithTwoOperands {$0 + $1}
        case "-": operationWithTwoOperands {$0 - $1}
        case "×": operationWithTwoOperands {$0 * $1}
        case "÷": operationWithTwoOperands {$0 / $1}
        default: break
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
        
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.orange
        })
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = (firstOperand * currentInput) / 100
        }
        stillTyping = false
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        stillTyping = true
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
    
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBAction func divisionButtonTapped(_ sender: Any) {
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.white
            })
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.orange
        })
    }
    
    @IBAction func multiplyButtonTapped(_ sender: Any) {
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.white
        })
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.orange
        })
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.white
        })
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.orange
        })
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        UIButton.animate(withDuration: 1, animations: {
            self.plusButton.backgroundColor = UIColor.white
        })
        UIButton.animate(withDuration: 1, animations: {
            self.divisionButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.multiplyButton.backgroundColor = UIColor.orange
        })
        UIButton.animate(withDuration: 1, animations: {
            self.minusButton.backgroundColor = UIColor.orange
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundButtons()
    }
    
    private func roundButtons() {
        var baseCornerRadius: CGFloat?
        
        for i in 0...19 {
            guard let button = view.viewWithTag(i) as? UIButton else {
                continue
            }
            
            if baseCornerRadius == nil {
                baseCornerRadius = button.frame.width / 2
            }
            button.layer.cornerRadius = baseCornerRadius!
        }
    }
}

