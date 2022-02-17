//
//  HomeViewModel.swift
//  AirLiftTask
//
//  Created by Rafay Abrar on 17/02/2022.
//

import Foundation

class HomeViewModel:NSObject{
    

    var galleryModel:GalleryModel?
    var responseSuccessful:(()->Void)?
    var errorOccured:((String)->Void)?
    var page = 1
    var perPage = 20
    
    func gettingData(){
        
        let url =  URL(string: "https://pixabay.com/api/?key=25751315-e0fba61dd809ca3f7fcf2d2f1&image_type=photo&pretty=true&page=\(page)&per_page=\(perPage)")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] data, response, error in
            
            guard let self = self else {return}
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                     let response = try decoder.decode(GalleryModel.self, from: data)
                print(response)
                if self.galleryModel == nil{
                self.galleryModel = response
                }else{
                    self.galleryModel?.hits?.append(contentsOf: response.hits ?? [])
                }
                
                self.page += 1
                self.responseSuccessful?()

            } catch {
                print(error)
                self.errorOccured?(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}
