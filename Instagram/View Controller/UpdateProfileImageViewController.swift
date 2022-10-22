//
//  UpdateProfileImageViewController.swift
//  Instagram
//
//  Created by Trang Do on 10/22/22.
//

import UIKit
import Parse
import AlamofireImage

class UpdateProfileImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .camera
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af.imageAspectScaled(toFit: size)
        profileImage.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpdateImage(_ sender: Any) {
        let user = PFUser.current()
        
        let imageData = profileImage.image!.pngData()!
        let file = PFFileObject(name: "image.png", data: imageData)
        
        user!["profileImage"] = file
        
        user!.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
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
