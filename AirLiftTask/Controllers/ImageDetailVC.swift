//
//  ImageDetailVC.swift
//  AirLiftTask
//
//  Created by Rafay Abrar on 17/02/2022.
//

import UIKit

class ImageDetailVC: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var data:Hits?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0

        scrollView.maximumZoomScale = 6.0
        activityIndicator.hidesWhenStopped = true
        if let hit = self.data{
            activityIndicator.startAnimating()
            
            imgView.kf.setImage(with: URL(string: hit.largeImageURL ?? ""), placeholder: nil, options: nil) { [unowned self] result in
                self.activityIndicator.stopAnimating()
                switch result{
                case .success(let _img):
                    self.imgView.image = _img.image
                    
                case .failure(_):
                    break
                }
                
            }
        }
        
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }

}
