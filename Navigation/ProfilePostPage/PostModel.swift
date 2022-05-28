//
//  PostModel.swift
//  Navigation
//
//  Created by roman Khilchenko on 03.05.2022.
//

import UIKit

struct ModelPost {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
    
    static func makePost() -> [ModelPost] {
        var model = [ModelPost]()
        
        model.append(ModelPost(author: "Traveler Cat", description: "Он словно сторонился других кошек и при этом обожал людское общество — до такой степени, что каждый день отправлялся в путешествие, чтобы повидать побольше людей.", image: "путешественник", likes: 700, views: 900))
        model.append(ModelPost(author: "Mountaineer Cat", description: "Как-то раз Томба привел компанию альпинистов на вершину, а затем спустился вниз только для того, чтобы подняться снова уже с другой группой! Благодарные гости угощали Томбу, после чего он, довольный собой, умывал шубку и начинал спуск вместе со своими «подопечными».", image: ("альпинист"), likes: 900, views: 1200))
        model.append(ModelPost(author: "Swimmer Cat", description: "супер редкий кот, которого можно получить из редких кошачьих капсул. Истинная форма была введена в версии 6.10, и она даёт ему увеличенные здоровье, силу и дальность атаки и скорость передвижения.", image: ("плавец"), likes: 360, views: 780))
        model.append(ModelPost(author: "Killer Cat", description: "Больше всего в книге «Дневник кота убийцы», которую написала Энн Файн, мне понравился кот. С ним происходит много интересного и смешного. Например, как проповедник запустил Таффи на соседский двор и как пытался снять его с дерева.", image: ("киллер"), likes: 680, views: 800))
        
        return model
    }
}
