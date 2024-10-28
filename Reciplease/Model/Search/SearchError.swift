//
//  SearchError.swift
//  Reciplease
//
//  Created by Sébastien DAGUIN on 23/11/2022.
//

import Foundation

enum SearchError : Error {
    case invalidField, invalidCharacter, ingredientFieldEmpty, noNewsFound ,uknowError
}

extension SearchError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidField :
            return NSLocalizedString("Le text n'est pas valide", comment: "Champ invalid")
        case .invalidCharacter :
            return NSLocalizedString("Le charactère n'est pas pris en charge.", comment: "Charactère non pris en charge.")
        case .ingredientFieldEmpty :
            return NSLocalizedString("Oups... Ce champ ne peut pas être vide", comment: "Champ vide")
        case .noNewsFound :
            return NSLocalizedString("Oups... Nous n'avons rien trouvé.", comment: "Pas de news trouver")
        case .uknowError :
            return NSLocalizedString("Une erreur inconnue est survenue", comment: "Unknow Error")
        }
        
    }
    
}
