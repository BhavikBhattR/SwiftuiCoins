//
//  MarketDataModel.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 28/01/23.
//

//JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSONResponse:
 {
   "data": {
     "active_cryptocurrencies": 12413,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 644,
     "total_market_cap": {
       "btc": 47147796.445379026,
       "eth": 681394697.4073293,
       "ltc": 12381853243.7676,
       "bch": 8065852581.371359,
       "bnb": 3539969740.0370345,
       "eos": 977719143417.493,
       "xrp": 2653987131909.3726,
       "xlm": 11762127960279.941,
       "link": 147485566062.56998,
       "dot": 168148196363.6301,
       "yfi": 142148922.5684774,
       "usd": 1093712373215.7726,
       "aed": 4017150861202.879,
       "ars": 203000169347768.62,
       "aud": 1538922212994.1067,
       "bdt": 115962826333611.47,
       "bhd": 412290191056.9111,
       "bmd": 1093712373215.7726,
       "brl": 5582636066605.275,
       "cad": 1454812450356.6943,
       "chf": 1007444716066.006,
       "clp": 881816538028950.6,
       "cny": 7419197883709.221,
       "czk": 23956675822918.3,
       "dkk": 7485819185498.8955,
       "eur": 1006448344094.006,
       "gbp": 882611666924.2769,
       "hkd": 8562947597999.6045,
       "huf": 391831159280192.5,
       "idr": 16382608267161772,
       "ils": 3762665866203.0293,
       "inr": 89114594832097.34,
       "jpy": 142090517936225.66,
       "krw": 1346985211167234.5,
       "kwd": 333880857308.6988,
       "lkr": 398212208660382.5,
       "mmk": 2297375022426313.5,
       "mxn": 20523403312156.66,
       "myr": 4642262168114.3545,
       "ngn": 503413931143757,
       "nok": 10807781306901.25,
       "nzd": 1685721381439.5005,
       "php": 59742947955675.336,
       "pkr": 265285050322543.22,
       "pln": 4736383773816.178,
       "rub": 76270040002188.72,
       "sar": 4105462666778.1875,
       "sek": 11277496866113.865,
       "sgd": 1435623266768.6218,
       "thb": 35884702965209.55,
       "try": 20569886088018.367,
       "twd": 33095188463610.36,
       "uah": 40198591117814.33,
       "vef": 109513419930.09547,
       "vnd": 25664965592785460,
       "zar": 18799603240731.277,
       "xdr": 808812330829.1687,
       "xag": 46414156347.374825,
       "xau": 566597694.9444337,
       "bits": 47147796445379.02,
       "sats": 4714779644537903
     },
     "total_volume": {
       "btc": 3072252.876442977,
       "eth": 44401159.267918155,
       "ltc": 806828465.2057827,
       "bch": 525588482.65138596,
       "bnb": 230672121.2082396,
       "eos": 63710304132.61574,
       "xrp": 172939569073.9724,
       "xlm": 766445818966.8405,
       "link": 9610479995.485794,
       "dot": 10956901889.260887,
       "yfi": 9262732.707990164,
       "usd": 71268675058.99658,
       "aed": 261766280057.942,
       "ars": 13227932188084.68,
       "aud": 100279515734.53706,
       "bdt": 7556389770551.263,
       "bhd": 26865724824.93963,
       "bmd": 71268675058.99658,
       "brl": 363776698103.6368,
       "cad": 94798740816.47505,
       "chf": 65647287045.04322,
       "clp": 57461081953066.71,
       "cny": 483451057262.70514,
       "czk": 1561069058492.2627,
       "dkk": 487792246066.5727,
       "eur": 65582361282.06445,
       "gbp": 57512894279.834496,
       "hkd": 557980274205.6501,
       "huf": 25532569853464.34,
       "idr": 1067526356841206.4,
       "ils": 245183484745.21442,
       "inr": 5806900660206.679,
       "jpy": 9258926935229.59,
       "krw": 87772483584230.83,
       "kwd": 21756402241.285084,
       "lkr": 25948372898167.074,
       "mmk": 149701949042186.03,
       "mxn": 1337349560614.5657,
       "myr": 302499891287.91156,
       "ngn": 32803545756155.027,
       "nok": 704258517077.4905,
       "nzd": 109845268569.6306,
       "php": 3892980320228.6455,
       "pkr": 17286550387884.227,
       "pln": 308633059657.4632,
       "rub": 4969921554119.866,
       "sar": 267520869225.58072,
       "sek": 734866203686.4033,
       "sgd": 93548331912.56485,
       "thb": 2338325228685.681,
       "try": 1340378479304.5754,
       "twd": 2156554401679.0364,
       "uah": 2619427555511.2285,
       "vef": 7136132433.657339,
       "vnd": 1672384932296729,
       "zar": 1225023001854.081,
       "xdr": 52703969161.5536,
       "xag": 3024447293.3341565,
       "xau": 36920737.11431336,
       "bits": 3072252876442.977,
       "sats": 307225287644297.75
     },
     "market_cap_percentage": {
       "btc": 40.88078012793128,
       "eth": 17.691887560887736,
       "usdt": 6.159070899909905,
       "usdc": 3.952437794676865,
       "bnb": 3.8110307467578832,
       "xrp": 1.9138241296336018,
       "busd": 1.4193770383401936,
       "ada": 1.2306856368783725,
       "doge": 1.0967329115157596,
       "matic": 0.9656624756553526
     },
     "market_cap_change_percentage_24h_usd": 0.9933553368167347,
     "updated_at": 1674845732
   }
 }
 */

import Foundation


struct GlobalData: Codable {
    let data: MarketDataModel?
}


struct MarketDataModel: Codable{
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    var marketCap: String{
        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
            return key == "usd"
        }){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String{
        if let item = totalVolume.first(where: { (key, value) -> Bool in
            return key == "usd"
        }){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: { (key, value) -> Bool in
            return key == "btc"
        }){
            return item.value.asPercentageString()
        }
        return ""
    }
    
    enum CodingKeys: String, CodingKey{
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
}
