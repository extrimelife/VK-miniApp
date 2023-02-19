//
//  ImageModel.swift
//  Navigation
//
//  Created by roman Khilchenko on 05.05.2022.
//

import UIKit

struct ImageModel {
    var image: String
    
    static func makeImage() -> [ImageModel] {
        var image = [ImageModel]()
        
        image.append(ImageModel(image: "original1"))
        image.append(ImageModel(image: "original2"))
        image.append(ImageModel(image: "original3"))
        image.append(ImageModel(image: "original4"))
        image.append(ImageModel(image: "original5"))
        image.append(ImageModel(image: "original6"))
        image.append(ImageModel(image: "original7"))
        image.append(ImageModel(image: "original8"))
        image.append(ImageModel(image: "original9"))
        image.append(ImageModel(image: "original10"))
        image.append(ImageModel(image: "original11"))
        image.append(ImageModel(image: "original12"))
        image.append(ImageModel(image: "original13"))
        image.append(ImageModel(image: "original14"))
        image.append(ImageModel(image: "original15"))
        image.append(ImageModel(image: "original16"))
        image.append(ImageModel(image: "original17"))
        image.append(ImageModel(image: "original18"))
        image.append(ImageModel(image: "original19"))
        image.append(ImageModel(image: "original20"))
        
        return image
    }
}
