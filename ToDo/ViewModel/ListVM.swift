//
//  ListVM.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/18/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import Foundation

class ListVM {
    
    var db = DBHelper()
    
    var updateData = { () -> () in}
    
    var dataArray : [List] = [] {
        didSet{
            updateData()
        }
    }
    
    
    func retreiveData() {
        dataArray =  db.getNotes()
    }
    
    func saveNote(obj : List){
        db.saveNote(list: obj)
        updateData()
    }
    
    func updateNote(obj : List){
           db.updateNote(list: obj)
           updateData()
       }
    
    func deleteNote(idNote : Int){
        db.deleteNote(idNote: idNote)
        updateData()
    }
    func showDate(oldDate : Double) -> String {
        let date = Date(timeIntervalSince1970: oldDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MMM/yy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
        
    }
}
