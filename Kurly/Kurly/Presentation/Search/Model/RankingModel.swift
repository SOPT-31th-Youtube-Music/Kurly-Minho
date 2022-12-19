//
//  RankingModel.swift
//  Kurly
//
//  Created by 김민 on 2022/11/30.
//

import Foundation

struct RankingModel: Hashable {
    let ranking: String
    let productNmae: String
}

let rankingData = [
    RankingModel(ranking: "1", productNmae: "룩트"),
    RankingModel(ranking: "2", productNmae: "에스티로더"),
    RankingModel(ranking: "3", productNmae: "호박인절미"),
    RankingModel(ranking: "4", productNmae: "두부텐더"),
    RankingModel(ranking: "5", productNmae: "꽃다발"),
    RankingModel(ranking: "6", productNmae: "파예"),
    RankingModel(ranking: "7", productNmae: "마"),
    RankingModel(ranking: "8", productNmae: "가니쉬"),
    RankingModel(ranking: "9", productNmae: "푸룬"),
    RankingModel(ranking: "10", productNmae: "들깨")
]
