//
//  ItemDetailsViewController.swift
//  DreamLister
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var priceTextField: CustomTextField!
    @IBOutlet weak var detailsTextField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let store = Store(context: context)
        store.name = "Gigantti"
        let store2 = Store(context: context)
        store2.name = "Verkkokauppa.com"
        let store3 = Store(context: context)
        store3.name = "Apple Store"
        let store4 = Store(context: context)
        store4.name = "Cdon.com"
        let store5 = Store(context: context)
        store5.name = "Levykauppa X"
        let store6 = Store(context: context)
        store6.name = "Rajala Pro Shop"

        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbnailImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = titleTextField.text {
            item.title = title
        }
        
        item.toImage = picture
        
        if let price = priceTextField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsTextField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            titleTextField.text = item.title
            priceTextField.text = "\(item.price)"
            detailsTextField.text = item.details
            
            thumbnailImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var i = 0
                repeat {
                    let s = stores[i]
                    if s.name == store.name {
                        storePicker.selectRow(i, inComponent: 0, animated: false)
                        break
                    }
                    i += 1
                } while (i < stores.count)
                
            }
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnailImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
