//
//  DBHelper.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/19/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import Foundation
import FMDB

class DBHelper:NSObject {
    
    let fieldId     = "id"
    let fieldTitle  = "title"
    let fieldBody   = "body"
    let fieldDate   = "date"
    
    var database: FMDatabase!
    
    override init() {
        super.init()
        
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            let fileURL = try! FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("databse.sqlite")
            
            database = FMDatabase(url: fileURL)
            print("open database ",database.databaseURL!)
            
            // Open the database.
            if database.open() {
                let createMoviesTableQuery = "CREATE TABLE IF NOT EXISTS 'List' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'title' TEXT, 'body' TEXT, 'date' DOUBLE)"
                
                do {
                    try database.executeUpdate(createMoviesTableQuery, values: nil)
                    
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
        if !database.isOpen {
            database.open()
        }
        return true
    }
    

    
    func getNotes() -> [List] {
        
        var notes : [List] = []
        let query = "SELECT * FROM List"
        if openDatabase() {
            do {
                
                let results = try database.executeQuery(query, values: nil)
                while results.next() == true {
                    let rowId       = results.int(forColumn: fieldId)
                    let rowTitle    = results.string(forColumn: fieldTitle)
                    let rowBody     = results.string(forColumn: fieldBody)
                    let rowDate     = results.double(forColumn: fieldDate)

                    var note : List!
                    note = List(id: Int(rowId), title: rowTitle!, body: rowBody!, date: rowDate)
                    
                    print("oh my god ",note)
                    
                    
                    //if let note = List(id: Int(rowId), title: rowTitle!, body: rowBody!, date: rowDate!){
                    notes.append(note)
                    
                }
                
                print(notes)
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
            if notes == nil {
                notes = [List]()
            }}
        return notes
        
    }
    
    
    func saveNote(list : List) {
        if openDatabase() {
            let query = "INSERT INTO List (title, body, date) VALUES (?, ?, ?)"
            do {
                try database.executeUpdate(query, values: [list.title, list.body, list.date])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    
    func updateNote(list : List) {
        if openDatabase() {
            let query = "UPDATE List SET title = ?, body = ?, date = ? WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [list.title, list.body, list.date, list.id])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
    func deleteNote(idNote : Int) {
        if openDatabase() {
            let query = "DELETE FROM List WHERE id = ?"
            do {
                try database.executeUpdate(query, values: [idNote])
                
            } catch {
                print("error \(error)")
            }
            database.close()
        }
    }
}
