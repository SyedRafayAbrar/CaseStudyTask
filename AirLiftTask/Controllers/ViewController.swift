//
//  ViewController.swift
//  AirLiftTask
//
//  Created by Rafay Abrar on 17/02/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var viewModel = HomeViewModel()
    
    var getCellSize:CGSize{
        return CGSize(width: self.myCollectionView.frame.width, height: self.myCollectionView.frame.width/2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myCollectionView.register(UINib(nibName: ImageCVC.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCVC.identifier)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.prefetchDataSource = self
        
        self.viewModel.gettingData()
        bindViewModel()
    }
    
    func bindViewModel(){
        self.viewModel.responseSuccessful = {
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
            
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.galleryModel?.hits?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCVC.identifier, for: indexPath) as? ImageCVC
        if let _hits = self.viewModel.galleryModel?.hits{
            cell?.configureData(data: _hits[indexPath.item])
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ImageDetailVC.identifier) as? ImageDetailVC{
            
            vc.data = self.viewModel.galleryModel?.hits?[indexPath.item]
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if (self.viewModel.galleryModel?.hits?.count ?? 0) < (self.viewModel.galleryModel?.totalHits ?? 0){
            self.viewModel.perPage = indexPaths.count >= 20 ? indexPaths.count : 20
            self.viewModel.gettingData()
        }
    }
}

