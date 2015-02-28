//
//  ViewController.m
//  WJSCountDown
//
//  Created by 王剑粟 on 15/1/16.
//  Copyright (c) 2015年 王剑粟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet WJSCountDown *lblXib;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //继承自WJCountDown的label
    [self.lblXib setTwoDateWithTime:@"2015-01-16 20:00:00" toDate:@"2015-01-16 20:01:00" withFormate:formateWithSecMin];
    //实现代理
    self.lblXib.delegate = self;
    
    //初始化传入两个具体时间，格式为yyyy-MM-dd HH:mm:ss 以分秒的形式展示
    WJSCountDown * lblStyleOne = [[WJSCountDown alloc] initWithFrame:CGRectMake(10, 90, 250, 30)];
    [lblStyleOne setTwoDateWithTime:@"2015-01-16 20:00:00" toDate:@"2015-01-16 20:02:00" withFormate:formateWithSecMin withBlock:^(UILabel *label, NSInteger countDownState, NSTimeInterval timeStamp) {
        if (countDownState == countDownGoing) {
            label.textColor = [self randomColor];
        }else if (countDownState == countDownFinish){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"labelTwo倒计时完成." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }];
    [self.view addSubview:lblStyleOne];
    
    //初始化传入两个具体时间，格式为yyyy-MM-dd 以时分秒的形式展示
    WJSCountDown * lblStyleTwo = [[WJSCountDown alloc] initWithFrame:CGRectMake(10, 150, 250, 30)];
    [lblStyleTwo setTwoDateWithTime:@"2015-01-16 20:00:00" toDate:@"2015-01-16 22:00:00" withFormate:formateWithSecMinHour];
    [self.view addSubview:lblStyleTwo];
    
    //初始化传入两个具体时间，格式为yyyy-MM-dd 以天时分秒的形式展示
    WJSCountDown * lblStyleThree = [[WJSCountDown alloc] initWithFrame:CGRectMake(10, 210, 250, 30)];
    [lblStyleThree setTwoDate:@"2014-01-01" toDate:@"2015-01-01" withFormate:formateWithSecMinHourDay];
    [self.view addSubview:lblStyleThree];
    
    //初始化传入两个时间戳的倒计时,以月天时分秒的形式展示
    WJSCountDown * lblStyleFour = [[WJSCountDown alloc] initWithFrame:CGRectMake(10, 270, 250, 30)];
    [lblStyleFour setTwoTimeStamp:1415636593 toTime:1421405839 withFormate:formateWithSecMinHourDayMon];
    [self.view addSubview:lblStyleFour];
    
    //初始化传入一个时间戳的倒计时,以年月天时分秒的形式展示
    WJSCountDown * lblStyleFive = [[WJSCountDown alloc] initWithFrame:CGRectMake(10, 330, 250, 30)];
    [lblStyleFive setSeconds:288000000 withFormate:formateWithSecMinHourDayMonYear];
    [self.view addSubview:lblStyleFive];
    
    
}

#pragma mark - 倒计时代理实现
- (void)wjsCountDownProgress:(UILabel *)label state:(NSInteger)countDownState timeStamp:(NSTimeInterval)timeStamp
{
    if (label.tag == 100 && countDownState == countDownGoing) {
        label.textColor = [self randomColor];
    }else if(label.tag == 100 && countDownState == countDownFinish){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"倒计时结束" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - 随机生产颜色
- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
