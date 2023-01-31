//
//  StatisticView.swift
//  SwiftuiCoins
//
//  Created by Bhavik Bhatt on 27/01/23.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
                HStack(spacing: 4) {
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                    Text(stat.percentageChange?.asPercentageString() ?? "")
                        .font(.caption)
                    .bold()
                }
                .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 40){
            StatisticView(stat: DeveloperPreview.instance.stat1)
            StatisticView(stat: DeveloperPreview.instance.stat2)
            StatisticView(stat: DeveloperPreview.instance.stat3)
        }
    }
}
