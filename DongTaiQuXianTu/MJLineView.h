//
//  MJLineView.h
//  动态折线图
//
//  Created by MJ on 2017/7/19.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJLineView : UIView
//x轴坐标
@property(nonatomic,strong)NSArray *XArr;
//y轴坐标
@property(nonatomic,strong)NSArray *YArr;
//实际数据的x坐标
@property(nonatomic,strong)NSArray *realXArr;
//实际数据的y坐标
@property(nonatomic,strong)NSArray *realYArr;
//坐标的提示框
@property(nonatomic,strong)NSArray *tipLabelsArr;
//实际数据的点
@property(nonatomic,strong)NSArray *buttonsArr;

- (instancetype)initWithXArr:(NSArray *)XArr andYArr:(NSArray *)YArr andRealXArr:(NSArray *)realXArr andRealYArr:(NSArray *)realYArr;

-(void)start;

@end
