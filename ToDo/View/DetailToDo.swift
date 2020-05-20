//
//  DetailToDo.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/18/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit


class DetailToDo: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txvBody: UITextView!
    @IBOutlet weak var btnDone: UIButton!
    var idNote  : Int?
    var nTitle  : String?
    var nBody   : String?
    var isNew = true
    
    var viewModel = ListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtTitle.becomeFirstResponder()
        txvBody.text = "Detail"
        txvBody.textColor = UIColor.placeholderText
        
        print("lier ",idNote)
        if idNote != nil{
            isNew = false
            txtTitle.text   = nTitle
            txvBody.text    = nBody
        }
        
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = nil
            textView.textColor = UIColor.darkGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Detail"
            textView.textColor = UIColor.placeholderText
        }
    }
    @IBAction func btnDone(_ sender: Any) {
        
        saveCurrent()
        self.navigationController?.popViewController(animated: true)
    }
    func saveCurrent(){
        let title   = txtTitle.text
        let body    = getBodyText(body: txvBody.text)
        let date    = NSDate().timeIntervalSince1970
        
        let note = List(id: idNote ?? 0, title: title!, body: body, date: Double(date))
        print(note)
        print(idNote)
        if isNew{
            self.addNote(obj: note)
        }else{
            self.updateNote(obj: note)
        }
    }
    
    func getBodyText(body : String) -> String {
        var newBody = body
        if (newBody == "Detail"){
            newBody = ""
        }
        return newBody
    }
    
    func addNote(obj : List) {
        viewModel.saveNote(obj: obj)
    }
    
    func updateNote(obj : List) {
        viewModel.updateNote(obj: obj)
    }
    @IBAction func btnCalendar(_ sender: Any) {
        
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
               let vc = storyboard.instantiateViewController(withIdentifier: "CalendarView") as? CalendarView
        vc!.nTitle = txtTitle.text
        vc!.nBody = getBodyText(body: txvBody.text)
               self.present(vc!, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtTitle {
            self.txvBody.becomeFirstResponder()
        }
        
        return true
    }
    
}
