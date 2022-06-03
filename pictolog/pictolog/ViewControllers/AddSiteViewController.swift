//
//  AddSiteViewController.swift
//  pictolog
//
//  Created by Parth Raval on 2022-05-14.
//

import UIKit
import CoreData

class AddSiteViewController: UIViewController {

    @IBOutlet weak var txtFieldSiteName: UITextField!
    @IBOutlet weak var txtFieldCity: UITextField!
    @IBOutlet weak var txtFieldProvince: UITextField!
    @IBOutlet weak var txtFieldCountry: UITextField!
    @IBOutlet weak var txtFieldNote: UITextField!
    @IBOutlet weak var txtFieldLatitude: UITextField!
    @IBOutlet weak var txtFieldLongitude: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    
    @IBOutlet weak var btnCamera: UIButton!
    
    var images:[UIImage] = []
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var datePickerCompact: UIDatePicker!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionViewImages.dataSource = self
        collectionViewImages.delegate = self
        imagePicker.delegate = self
    }
      
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddTapped(_ sender: UIButton) {
        
        if txtFieldSiteName.text!.trim().isEmpty {
            showAlertView(title: "Error", message: "Invalid Place Name")
            return
        }
        
        if txtFieldCity.text!.trim().isEmpty {
            showAlertView(title: "Error", message: "Invalid City")
            return
        }
        
        if txtFieldProvince.text!.trim().isEmpty {
            showAlertView(title: "Error", message: "Invalid Province")
            return
        }
        
        if txtFieldCountry.text!.trim().isEmpty {
            showAlertView(title: "Error", message: "Invalid Country")
            return
        }
        
        if txtFieldNote.text!.trim().isEmpty {
            showAlertView(title: "Error", message: "Invalid Note")
            return
        }
        
        let placeName = txtFieldSiteName.text!.trim()
        let forCity = txtFieldCity.text!.trim()
        let forProvince = txtFieldProvince.text!.trim()
        let forCountry = txtFieldCountry.text!.trim()
        let note = txtFieldNote.text!.trim()
        
        
        guard let latitude = Double(txtFieldLatitude.text!) else {
            showAlertView(title: "Error", message: "Invalid Latitude")
            return
        }
        
        guard let longitude = Double(txtFieldLongitude.text!) else {
            showAlertView(title: "Error", message: "Invalid Longitude")
            return
        }
        

        let dateFormatter = ISO8601DateFormatter()
        
        let country = DataManager.shared.createCountry(name: forCountry)
        let province = DataManager.shared.createProvince(name: forProvince, country: country)
        let city = DataManager.shared.createCity(name: forCity, province: province, country: country)
        
        var imagesDataArr:[Data] = []
        for image in images {
            if let imageData = image.pngData() {
                imagesDataArr.append(imageData)
            }
        }
        
        let images = DataManager.shared.createImage(imagesData: imagesDataArr)

        let newPlace = DataManager.shared.createPlace(name: placeName, city: city, province: province, country: country, visitedOn: dateFormatter.date(from:dateFormatter.string(from: (datePickerCompact.date)))!, latitude: latitude, longitude: longitude, note: note, images: images)
        
        
        do {
            try DataManager.shared.saveContext()
            showAlertView(title: "Success", message: "New Place has been added in your journal successfully")
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
    @IBAction func btnCameraTapped(_ sender: UIButton) {
        print("pressed btn")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Other Methods
    
    func showAlertView(title: String, message: String) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (_: UIAlertAction!) in
                if(title == "Success") {
                    self.navigationController?.popViewController(animated: true)
                }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToImageVC(withimageData: Data) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        vc.imageData = withimageData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AddSiteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - CollectionView Delegate Methods For Gallary
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgViewCapturedImg.image = images[indexPath.row]
        cell.imgViewCapturedImg.contentMode = .scaleAspectFit
        cell.imgViewCapturedImg.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100,height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToImageVC(withimageData: images[indexPath.row].pngData()!)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // add image into the image array and relaod the collection view
            images.append(pickedImage)
            collectionViewImages.reloadData()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
