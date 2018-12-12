
import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var toDoField: UITextField!
    
    @IBOutlet weak var toDonoteview: UITextView!
    var toDoItem: String?
    var toDonoteItem: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoItem = toDoItem{
            toDoField.text = toDoItem
        }
        if let toDonoteItem = toDonoteItem{
            toDonoteview.text = toDonoteItem
        }
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave"{
            toDoItem = toDoField.text
            toDonoteItem = toDonoteview.text
        }
    }
    /* override func viewDidLoad() {
     super.viewDidLoad()
     
     // Do any additional setup after loading the view.
     }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
}
