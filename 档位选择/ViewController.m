//
//  ViewController.m
//  档位选择
//
//  Created by 曹记 on 2017/12/30.
//  Copyright © 2017年 曹记. All rights reserved.
//

#import "ViewController.h"
#import "JGProgressView.h"
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
//屏幕宽度和高度
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define MultiplyingPower (HEIGHT/568)

//颜色
#define LOGCOLOR [UIColor colorWithRed:243/255.0 green:193/255.0 blue:119/255.0 alpha:1.0]
@interface ViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)JGProgressView *PV;

@property (nonatomic,strong)UILabel *LevleLbl;
@property (nonatomic,strong)UILabel *selectLabel;
@property (nonatomic,assign)int level;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:247/255.0 green:249/255.0 blue:251/255.0 alpha:1.0];
    //展示选中的段位
    self.selectLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 130*MultiplyingPower, kDeviceWidth, 20*MultiplyingPower)];
    self.selectLabel.text =[NSString stringWithFormat:@"当前选中了  %@  档",@"2"];
    self.selectLabel.tag =109;
    self.selectLabel.textColor =[UIColor lightGrayColor];
    self.selectLabel.textAlignment =NSTextAlignmentCenter;
    self.selectLabel.font =[UIFont systemFontOfSize:18];
    [self.view addSubview:self.selectLabel];
    [self CreatMyslider];
}
-(void)CreatMyslider{
    _PV = [[JGProgressView alloc] initWithFrame:CGRectMake(30, 230*MultiplyingPower, kDeviceWidth - 50, 40)];
    _PV.progress =2*0.2;
    [self.view addSubview:_PV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_PV addGestureRecognizer:tap];
    //panGR.numberOfTouches =1;
    tap.delegate =self;
    for (int i=0; i<6; i++) {
        _LevleLbl =[[UILabel alloc]initWithFrame:CGRectMake(30+i*(WIDTH-60)/5, 263*MultiplyingPower, 15, 20)];
        _LevleLbl.tag =10000+i;
        if (i==5) {
            _LevleLbl.frame =CGRectMake(WIDTH-45, 263*MultiplyingPower, 18, 20);
            _LevleLbl.textAlignment =NSTextAlignmentRight;
        }else{
            if (i!=0) {
                _LevleLbl.frame =CGRectMake( 20+i*(WIDTH-60)/5, 263*MultiplyingPower, 15, 20);
            }else{
                _LevleLbl.frame =CGRectMake(30+i*(WIDTH-60)/5, 263*MultiplyingPower, 60, 20);
            }
            _LevleLbl.textAlignment =NSTextAlignmentLeft;
        }
        if (i==0) {
            _LevleLbl.text =[NSString stringWithFormat:@"%@",@"停止"];
            _LevleLbl.font =[UIFont systemFontOfSize:10*MultiplyingPower];
        }else{
            _LevleLbl.text =[NSString stringWithFormat:@"%d",i];
            
        }
        if (2==i) {
            _LevleLbl.textColor =LOGCOLOR;
        }else{
            _LevleLbl.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        }
        [self.view addSubview:_LevleLbl];
    }
}
//档位
- (void)tapAction:(UITapGestureRecognizer *)tap
{       //当前坐标
    CGPoint p = [tap locationInView:tap.view];
    NSLog(@"%f====%f",p.x,p.y);
    CGFloat index =(WIDTH-50)/5;
    _level =0;
    if (p.x<=0.5*index){
        _level=0;
        _PV.progress = 0;
    }else if (p.x>0.5*index&&p.x<=1.5*index) {
        _level=1;
        _PV.progress = 0.2;
    }else if (p.x>1.5*index&&p.x<=2.5*index) {
        _level=2;
        _PV.progress = 0.4;
    }else  if (p.x>2.5*index&&p.x<=3.5*index) {
        _level=3;
        _PV.progress = 0.6;
    }else if (p.x>3.5*index&&p.x<=4.5*index) {
        _level=4;
        _PV.progress = 0.8;
    }else{
        _level=5;
        _PV.progress = 1;
    }
    self.selectLabel.text =[NSString stringWithFormat:@"当前选中了  %d  档",_level];
    //改变选中的颜色
    for (id tmpview in self.view.subviews) {
        if ([tmpview isKindOfClass:[UILabel class]]) {
            UILabel* vc =(UILabel*)tmpview;
            NSInteger labeTag =vc.tag%10000;
            if (labeTag==_level) {
                vc.textColor =LOGCOLOR;
            }else{
                vc.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
