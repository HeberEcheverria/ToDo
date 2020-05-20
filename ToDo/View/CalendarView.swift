//
//  calendarView.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/19/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit
import EventKit

class CalendarView: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    var nTitle  : String?
    var nBody   : String?
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        container.roundCorners(corners: [.topLeft, .topRight], radius: 12.0)
        // Do any additional setup after loading the view.
        let currentDate = Date()
        
        datePicker.datePickerMode = UIDatePicker.Mode.date // use date only
         //get the current date
        datePicker.minimumDate = currentDate  //set the current date/time as a minimum
        datePicker.date = currentDate
        
        timePicker.datePickerMode = UIDatePicker.Mode.time // use date only
        //get the current date
        timePicker.minimumDate = currentDate  //set the current date/time as a minimum
        timePicker.date = currentDate
        
        requestPermission()
    }
    func statusPermission() {
        
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Access granted")
            insertEvent(store: eventStore)
        case .denied:
            requestAgainPermission()
         print("Access denied")
        case .notDetermined:
            print("Access notDetermined")
        default:
            print("Access default")
        }
    }
    func requestPermission(){
        
        eventStore.requestAccess(to: .event, completion:
            
            {[weak self] (granted: Bool, error: Error?) -> Void in
                if granted {
                    print("Access granted")
                } else {
                    print("Access denieds")
                }
        })
    }
    func requestAgainPermission(){
        let alertController = UIAlertController (title: "We need access to the calendar", message: "Go to 'ToDo' Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func insertEvent(store: EKEventStore) {
        print("evento insertado")
       
               
        
     
                        let startDate = Date()
                        let endDate = startDate.addingTimeInterval(60 * 60)
                        let event = EKEvent(eventStore: store)
                        event.calendar = eventStore.defaultCalendarForNewEvents
        
                        event.title = nTitle
                        event.notes = nBody
                        event.startDate = startDate
                        event.endDate = endDate

                        do {
                            try store.save(event, span: .thisEvent)
                            self.dismiss(animated: true, completion: nil)
                        }
                        catch {
                            print("Error saving event in calendar", error.localizedDescription)
                        }
            
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnOk(_ sender: Any) {
        statusPermission()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
