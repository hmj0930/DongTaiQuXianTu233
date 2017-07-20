//
//  ViewController.m
//  动态折线图
//
//  Created by MJ on 2017/7/18.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "ViewController.h"
#import "MJLineView.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *XArr;

@property(nonatomic,strong)NSArray *YArr;

@property(nonatomic,strong)NSArray *realXArr;

@property(nonatomic,strong)NSArray *realYArr;

@property(nonatomic,strong)MJLineView *mjView;

@end

@implementation ViewController

-(NSArray *)realXArr{
    
    if (_realXArr==nil) {
        _realXArr=@[@"0.5",@"0.8",@"1.2",@"2.3",@"4",@"4.5",@"5",@"6",@"6.5",@"7.8",@"9"];
    }
    return _realXArr;
}

-(NSArray *)realYArr{
    
    if (_realYArr==nil) {
        _realYArr=@[@"0.8",@"1.2",@"1.9",@"3",@"3.9",@"5",@"6",@"6.8",@"7.7",@"9",@"5"];
    }
    return _realYArr;
}


-(NSArray *)XArr{
    
    if (_XArr==nil) {
        _XArr=@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _XArr;
}

-(NSArray *)YArr{
    
    if (_YArr==nil) {
        _YArr=@[@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"0"];
    }
    return _YArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mjView=[[MJLineView alloc]initWithXArr:self.XArr andYArr:self.YArr andRealXArr:self.realXArr andRealYArr:self.realYArr];
    self.mjView.frame=CGRectMake(0, 0, 300, 300);
    self.mjView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:self.mjView];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.mjView start];
}

@end
