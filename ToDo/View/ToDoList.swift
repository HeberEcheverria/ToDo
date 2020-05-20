//
//  ToDoList.swift
//  ToDo
//
//  Created by Heber Echeverria on 5/18/20.
//  Copyright © 2020 Heber Echeverria. All rights reserved.
//

import UIKit

class ToDoList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = ListVM()
    private func configureView(){
        viewModel.retreiveData()
    }
    
    private func bind(){
        viewModel.updateData = {[weak self] () in
            self?.tableView.reloadData()
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureView()
               bind()
       
    }
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailToDo") as? DetailToDo
        self.navigationController?.show(vc!, sender: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let obj = viewModel.dataArray[indexPath.row]
        cell.lblTitle?.text = obj.title
        cell.lblBody?.text  = obj.body
        cell.lblDate?.text  = viewModel.showDate(oldDate: obj.date)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailToDo") as? DetailToDo
        let obj = viewModel.dataArray[indexPath.row]
        vc?.idNote  = obj.id
        vc?.nTitle  = obj.title
        vc?.nBody   = obj.body
        self.navigationController?.show(vc!, sender: nil)

           
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let obj = viewModel.dataArray[indexPath.row]
            let idNote  = obj.id
            viewModel.deleteNote(idNote: idNote)
            configureView()
            bind()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}
