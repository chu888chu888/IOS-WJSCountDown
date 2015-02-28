//
//  WJSCountDown.h
//  WJSCountDown
//
//  Created by 王剑粟 on 15/1/16.
//  Copyright (c) 2015年 王剑粟. All rights reserved.
//
//  该控件旨在实现继承于UILabel的倒计时控件，
//  支持传入时间戳或者是具体时间 （时间戳是以1970-01-01 00:00:00为基准,以秒为单位）
//  支持相应时间格式的展示，例如 "09:10"分秒,"10:12:10"时分秒,"1天20小时30分20秒"等。
//  支持代理和块定义方法来实现每秒监听和倒计时结束回调

#import <UIKit/UIKit.h>

#pragma mark - 倒计时块定义
typedef void (^wjsCountDownBlock)(UILabel *label, NSInteger countDownState, NSTimeInterval timeStamp);

#pragma mark - 倒计时delegate
@protocol WJSCountDownDelegate <NSObject>

@optional - (void) wjsCountDownProgress:(UILabel *)label state:(NSInteger)countDownState timeStamp:(NSTimeInterval)timeStamp;

@end

#pragma mark - 定义时间格式枚举类型
enum dateShowFormateType{
    formateWithSecMin = 0,              //定义秒分的格式 如"09:10"
    formateWithSecMinHour,              //定义秒分时的格式 如"49:09:01"
    formateWithSecMinHourDay,           //定义秒分时天的格式 如"3天19小时20分30秒"
    formateWithSecMinHourDayMon,        //定义秒分时天月的格式 如"1个月28天20小时30分20秒"
    formateWithSecMinHourDayMonYear     //定义秒分时天月年的格式 如"2年11个月20天19小时29分30秒"
};

#pragma mark - 定义定时的状态枚举类型 0代表计时还在继续，1代表计时已经结束
enum countDownState{
    countDownGoing = 0,
    countDownFinish
};

@interface WJSCountDown : UILabel{
    NSInteger dateFormat;               //定义时间的显示格式
    NSTimeInterval countTime;           //倒计时的时间戳数据
    NSTimer * timer;                    //定时器
    NSInteger state;                    //倒计时状态
}

@property (strong, nonatomic) wjsCountDownBlock countDownblock;
@property (strong, nonatomic) id<WJSCountDownDelegate> delegate;

#pragma mark ----------------- 各种设置方法
#pragma mark - 传入两个时间戳参数，以两个时间戳之间相差的时间为倒计时时间
- (void)setTwoTimeStamp:(NSTimeInterval) fromTime toTime:(NSTimeInterval) toTime withFormate:(NSInteger)formateType;
- (void)setTwoTimeStamp:(NSTimeInterval) fromTime toTime:(NSTimeInterval) toTime withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block;
#pragma mark - 传入单个秒数来实现倒计时
- (void)setSeconds:(NSTimeInterval) toTime withFormate:(NSInteger)formateType;
- (void)setSeconds:(NSTimeInterval) toTime withFormate:(NSInteger)formateType wihtBlock:(wjsCountDownBlock)block;
#pragma mark - 传入两个格式为yyyy-MM-dd HH:mm:ss的字符串时间参数，以两者相差的时间进行倒计时
- (void)setTwoDateWithTime:(NSString *) fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType;
- (void)setTwoDateWithTime:(NSString *) fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block;
#pragma mark - 传入两个格式为yyyy-MM-dd的字符串时间参数，以两者相差的时间进行倒计时
- (void)setTwoDate:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType;
- (void)setTwoDate:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block;

@end
