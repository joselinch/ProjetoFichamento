//
//  dataFolders.swift
//  ProjetoFichamento
//
//  Created by Eduarda Soares Serpa Camboim on 28/07/21.
//

import UIKit

struct Dados {
    let folder: String
    let recordsNumber: String
}

func mockData() -> [Dados]{
    return [
        Dados(
            folder: "TCC",
            recordsNumber: "3 Records"
        ),
        Dados(
            folder: "Projeto Física",
            recordsNumber: "1 Record"
        ),
        Dados(
            folder: "Artigo ef",
            recordsNumber: "0 Record"
        ),
    ]
}
