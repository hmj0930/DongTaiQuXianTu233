//
//  MJLineView.m
//  动态折线图
//
//  Created by MJ on 2017/7/19.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "MJLineView.h"
#define left 66
#define up 80
#define down 20

@interface MJLineView ()
//表格宽度
@property(nonatomic,assign)CGFloat width;
//表格高度
@property(nonatomic,assign)CGFloat height;
//行高
@property(nonatomic,assign)CGFloat hangHeight;
//列宽
@property(nonatomic,assign)CGFloat lieWidth;

@end

@implementation MJLineView

-(void)drawRect:(CGRect)rect{
    
    self.width=rect.size.width;
    self.height=rect.size.height;
    self.hangHeight=(self.height-100)/((self.YArr.count-1)*1.0);
    self.lieWidth=(self.width-132)/((self.XArr.count-1)*1.0);
    
    [self prepareColsAndCom:self.XArr andYArr:self.YArr andRealXArr:self.realXArr andRealYArr:self.realYArr];

}

-(void)prepareColsAndCom:(NSArray *)XArr andYArr:(NSArray *)YArr andRealXArr:(NSArray *)realXArr andRealYArr:(NSArray *)realYArr{
    
    CGFloat width=self.width;
    
    for (int i=0; i<self.XArr.count; i++) {
        
        UIView *shu=[UIView new];
        shu.backgroundColor=[UIColor lightGrayColor];
        shu.frame=CGRectMake(left+i*self.lieWidth, up, 1, self.height-up-down);
        [self addSubview:shu];
        
        UILabel *label=[UILabel new];
        label.text=self.XArr[i];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:13];
        label.adjustsFontSizeToFitWidth=YES;
        CGPoint center=shu.center;
        CGFloat y=CGRectGetMaxY(shu.frame);
        label.frame=CGRectMake(center.x-10,y+6 , (width-left*2)/(self.XArr.count), 20);
        [self addSubview:label];
    }
    
    
    for (int i=0; i<self.YArr.count; i++) {
        
        UIView *shu=[UIView new];
        shu.backgroundColor=[UIColor lightGrayColor];
        shu.frame=CGRectMake(left, up+self.hangHeight*i, self.width-left*2, 1);
        [self addSubview:shu];
        
        UILabel *label=[UILabel new];
        label.text=self.YArr[i];
        label.textAlignment=NSTextAlignmentRight;
        label.font=[UIFont systemFontOfSize:13];
        label.adjustsFontSizeToFitWidth=YES;
        CGPoint center=shu.center;
        label.frame=CGRectMake(40,center.y-10, 20, 20);
        [self addSubview:label];
    }
    
    for (int i=0; i<self.realXArr.count; i++) {
        
        UIButton *button=self.buttonsArr[i];
        CGFloat xmargin=([self.realXArr[i] floatValue]-[[self.XArr firstObject] floatValue])*(width-left*2)/([[self.XArr lastObject] floatValue]-[[self.XArr firstObject] floatValue])+left;
        CGFloat ymargin=([[self.YArr firstObject]floatValue]-[self.realYArr[i] floatValue])*(self.height-up-down)/([[self.YArr firstObject] floatValue]-[[self.YArr lastObject]floatValue])+up;
        button.frame=CGRectMake(xmargin-4,ymargin-4, 8, 8);
        [self addSubview:button];
        
        UILabel *label=self.tipLabelsArr[i];
        label.frame=CGRectMake(xmargin-30, ymargin-25, 60, 20);
        [self addSubview:label];
    }
}

-(NSArray *)buttonsArr{
    
    if (_buttonsArr==nil) {
        
        NSMutableArray *tmp=[NSMutableArray array];
        
        for (int i=0; i<self.realXArr.count; i++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.cornerRadius=4;
            button.layer.masksToBounds=YES;
            button.backgroundColor=[UIColor redColor];
            button.tag=100+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [tmp addObject:button];
        }
        _buttonsArr=[NSArray arrayWithArray:tmp];
    }
    return _buttonsArr;
}

-(NSArray *)tipLabelsArr{
    
    if (_tipLabelsArr==nil) {
        
        NSMutableArray *tmp=[NSMutableArray array];
        
        for (int i=0; i<self.realXArr.count; i++) {
            UILabel *label=[UILabel new];
            label.adjustsFontSizeToFitWidth=YES;
            label.text=[NSString stringWithFormat:@"(%.1f,%.1f)",[self.realXArr[i] floatValue],[self.realYArr[i] floatValue]];
            label.textColor=[UIColor redColor];
            label.hidden=YES;
            [tmp addObject:label];
        }
        _tipLabelsArr=[NSArray arrayWithArray:tmp];
    }
    return _tipLabelsArr;
}

-(void)buttonAction:(UIButton *)button{
    
    for (UILabel *label in self.tipLabelsArr) {
        label.hidden=YES;
    }
    
    NSInteger index=button.tag-100;
    
    UILabel *label=self.tipLabelsArr[index];
    label.hidden=NO;
}

- (instancetype)initWithXArr:(NSArray *)XArr andYArr:(NSArray *)YArr andRealXArr:(NSArray *)realXArr andRealYArr:(NSArray *)realYArr
{
    self = [super init];
    if (self) {

        self.XArr=XArr;
        self.YArr=YArr;
        self.realXArr=realXArr;
        self.realYArr=realYArr;

    }
    return self;
}

-(void)start{
    
    [self draw];
}

-(void)draw{
    
    CGFloat width=self.width;
    UIBezierPath *path=[UIBezierPath bezierPath];
    CAShapeLayer *layer=[CAShapeLayer layer];
    
    CGPoint prePoint;
    CGPoint nowPoint;
    
    for (int i=0; i<self.realXArr.count; i++) {
        
        CGFloat xmargin=([self.realXArr[i] floatValue]-[[self.XArr firstObject] floatValue])*(width-left*2)/([[self.XArr lastObject] floatValue]-[[self.XArr firstObject] floatValue])+left;
        CGFloat ymargin=([[self.YArr firstObject]floatValue]-[self.realYArr[i] floatValue])*(self.height-up-down)/([[self.YArr firstObject] floatValue]-[[self.YArr lastObject]floatValue])+up;
        
        if (i==0) {
            
            prePoint=CGPointMake(xmargin, ymargin);
            [path moveToPoint:prePoint];
        }else{
            
            nowPoint=CGPointMake(xmargin, ymargin);
            
            [path addCurveToPoint:nowPoint controlPoint1:CGPointMake((prePoint.x+nowPoint.x)/2.0, prePoint.y) controlPoint2:CGPointMake((prePoint.x+nowPoint.x)/2.0, nowPoint.y)];
            
            prePoint=nowPoint;
        }
    }
    layer.path=path.CGPath;
    layer.strokeColor=[UIColor redColor].CGColor;
    layer.fillColor=nil;
    layer.lineWidth=1;
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue=@(0);
    animation.toValue=@(1);
    animation.duration=6;
    [layer addAnimation:animation forKey:nil];
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    
    [self.layer addSublayer:layer];
}


@end
