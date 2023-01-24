//
//  ViewController.swift
//  MyImageWork
//
//  Created by Kumar Basant on 24/01/23.
//

import UIKit
import PhotosUI
class ViewController: UIViewController{
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var combinedImage: UIImageView!
    
    @IBOutlet weak var btnCombined: UIButton!
    
    @IBOutlet weak var btnSelecte: UIButton!
    
    @IBOutlet weak var imgConverted: UIImageView!
    @IBOutlet weak var btnJpg: UIButton!
    var imageName = "jpgImage"
    var indx = 0
 var imageIndx = 1
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.btnJpg.setCorner()
        self.btnSelecte.setCorner()
        self.btnSelecte.isHidden = true
        self.btnCombined.setCorner()
        self.imageView1.setCorner()
        self.imageView2.setCorner()
        self.combinedImage.setCorner()
        self.btnJpg.setTitleColor(.white, for: .normal)
        self.imageView1.contentMode = .scaleAspectFit
        self.imageView2.contentMode = .scaleAspectFit
        self.imageView1.image = UIImage(named: "img1")
        self.imageView2.image = UIImage(named: "img2")
        // Do any additional setup after loading the view.
    }

    private func showImagePicker() {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 2 // Selection limit. Set to 0 for unlimited.
            configuration.filter = .images // he types of media that can be get.
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
        }
    
    @IBAction func combineImage(_ sender: Any) {
        DispatchQueue.main.async {
            self.combinedImage.image = self.imageByCombiningImage(firstImage: self.imageView1.image!, withImage: self.imageView2.image!)
            self.combinedImage.contentMode = .scaleAspectFit
        }
    }
    @IBAction func convertImage(_ sender: Any) {
        self.convertToJPG(image: self.imageView1.image!)
    }
    @IBAction func selectImage_Action(_ sender:UIButton){
        showImagePicker()
    }
     func imageByCombiningImage(firstImage: UIImage, withImage secondImage: UIImage) -> UIImage {
        
         
         
         let size = CGSize(width: firstImage.size.width, height: firstImage.size.width)
         UIGraphicsBeginImageContext(size)
         let firstImageArea = CGRect(x: 0, y: 0, width: size.width/2, height: size.height)
         let secondImageArea = CGRect(x: size.width/2, y: 0, width: size.width/2, height: size.height)
         firstImage.draw(in:firstImageArea)
         secondImage.draw(in:secondImageArea)
         
         let concatenatedImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return concatenatedImage ?? UIImage()
         
    }
    func convertToJPG(image: UIImage) {
        
        if let jpegImage = image.jpegData(compressionQuality: 1.0){
                do {
                    //Convert
                    let tempDirectoryURL = URL(fileURLWithPath:  NSTemporaryDirectory(), isDirectory: true)
                    var imNma = imageName  + ".JPG"
                   // let newFileName = "\(imNma.append(".JPG"))"
                    let targetURL = tempDirectoryURL.appendingPathComponent(imNma)
                    print("targetURL=\(targetURL)")
                    try jpegImage.write(to: targetURL, options: [])
                    DispatchQueue.main.async {
                        self.imgConverted.image = image
                    }
                }catch {
                    print (error.localizedDescription)
                    print("FAILED")
                }
            }else{
                print("FAILED")
            }
        }
}

extension ViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            picker.dismiss(animated: true)
            return
        }
        let itemProviders = results.map(\.itemProvider)
            for item in itemProviders {
                DispatchQueue.main.async {
                if item.canLoadObject(ofClass: UIImage.self) {
                    item.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
                      
                            if let image = image as? UIImage {
                                self?.setImage(image: image, index: self!.indx,picker: picker)
//                                {
//
//
//                                }
                            }
                        }
                    }
                }
            }
    }
    func setImage(image:UIImage,index:Int,picker: PHPickerViewController){
        if self.indx == 0{
            print("index = 0")
            DispatchQueue.main.async {
                self.imageView1.image = nil
                self.imageView1.image = image
                self.imageView1.contentMode = .scaleAspectFit

            }
                        indx = 1
        }else if self.indx == 1{
            print("index = 1")
            DispatchQueue.main.async {
                self.imageView2.image = nil
                self.imageView2.image = image
                self.imageView2.contentMode = .scaleAspectFit
            }
            self.indx = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //print("Async after 1 seconds")
                picker.dismiss(animated: true)
               
            }
           // onCompletion()
           // return
        }
    }
    
}
