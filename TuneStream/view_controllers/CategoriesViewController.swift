//
//  ViewController.swift
//  TuneStream
//
//  Created by SusantShrestha on 12/14/23.
//

import UIKit

class CategoriesViewController: UIBaseViewController, UITableViewDataSource, UITableViewDelegate, CategoriesVMDelegate {
    
    private var categoryVM : CategoriesVM?
    
    private var categories = Array<Category>()
    
    @IBOutlet weak var tvCategories: UITableView!
    
    private var selectedCategory : Category?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvCategories.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! UICategoryTableViewCell
        
        let category = categories[indexPath.row] as Category
        cell.lbName.text = category.name
        if let imageUrl = category.icons.first?.url {
            cell.loadImage(url: imageUrl)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCategory = categories[indexPath.row]
        performSegue(withIdentifier: "seg_playlists", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_playlists" {
            if let destinationVC = segue.destination as? PlaylistsViewController {
                destinationVC.category = self.selectedCategory
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryVM = (UIApplication.shared.delegate as! AppDelegate).categoriesVM
        
        tvCategories.dataSource = self
        tvCategories.delegate = self
        categoryVM?.delegate = self
        
        categoryVM?.getCategories()
    }
    
    func onGetCategoriesSuccess(categories: [Category]) {
        self.categories = categories
        self.tvCategories.reloadData()
    }
    
    func onGetCategoriesFailed(error: String) {
        showError(message: error)
    }
}

