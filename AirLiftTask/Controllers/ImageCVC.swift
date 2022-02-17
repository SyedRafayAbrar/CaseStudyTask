//
//  ImageCVC.swift
//  AirLiftTask
//
//  Created by Rafay Abrar on 17/02/2022.
//

import UIKit
import Kingfisher

class ImageCVC: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var downloadLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureData(data:Hits){
        activityIndicator.startAnimating()
        self.likesLbl.text = "\(data.likes ?? 0)"
        self.commentLbl.text = "\(data.comments ?? 0)"
        self.downloadLbl.text = "\(data.downloads ?? 0)"
        imgView.kf.setImage(with: URL(string: data.previewURL ?? ""), placeholder: nil, options: nil) { [unowned self] result in
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
