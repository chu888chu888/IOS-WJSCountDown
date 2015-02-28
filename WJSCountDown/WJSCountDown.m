//
//  WJSCountDown.m
//  WJSCountDown
//
//  Created by 王剑粟 on 15/1/16.
//  Copyright (c) 2015年 王剑粟. All rights reserved.
//

#import "WJSCountDown.h"


@implementation WJSCountDown

#pragma mark ----------------- 各种计算倒计时的初始化方法
- (void)setTwoTimeStamp:(NSTimeInterval) fromTime toTime:(NSTimeInterval) toTime withFormate:(NSInteger)formateType
{
    if (fromTime < toTime) {
        //计算两者的时间差
        countTime = toTime - fromTime;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
        
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}

- (void)setTwoTimeStamp:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block
{
    if (fromTime < toTime) {
        //计算两者的时间差
        countTime = toTime - fromTime;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        self.countDownblock = block;
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
        
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}

- (void)setSeconds:(NSTimeInterval) toTime withFormate:(NSInteger)formateType
{
    if (toTime > 0) {
        countTime = toTime;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"倒计时时间过短无法倒计时";
    }
}

- (void)setSeconds:(NSTimeInterval) toTime withFormate:(NSInteger)formateType wihtBlock:(wjsCountDownBlock)block
{
    if (toTime > 0) {
        countTime = toTime;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        self.countDownblock = block;
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"倒计时时间过短无法倒计时";
    }
}

- (void)setTwoDateWithTime:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType
{
    NSTimeInterval fromTimeInterval = [[self stringWithTime:fromDate] timeIntervalSince1970];
    NSTimeInterval toTimeInterval = [[self stringWithTime:toDate] timeIntervalSince1970];
    if (fromTimeInterval < toTimeInterval) {
        //计算两者的时间差
        countTime = toTimeInterval - fromTimeInterval;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}

- (void)setTwoDateWithTime:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block
{
    NSTimeInterval fromTimeInterval = [[self stringWithTime:fromDate] timeIntervalSince1970];
    NSTimeInterval toTimeInterval = [[self stringWithTime:toDate] timeIntervalSince1970];
    if (fromTimeInterval < toTimeInterval) {
        //计算两者的时间差
        countTime = toTimeInterval - fromTimeInterval;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        self.countDownblock = block;
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}

- (void)setTwoDate:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType
{
    
    NSTimeInterval fromTimeInterval = [[self stringWithOutTime:fromDate] timeIntervalSince1970];
    NSTimeInterval toTimeInterval = [[self stringWithOutTime:toDate] timeIntervalSince1970];
    if (fromTimeInterval < toTimeInterval) {
        //计算两者的时间差
        countTime = toTimeInterval - fromTimeInterval;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}

- (void)setTwoDate:(NSString *)fromDate toDate:(NSString *)toDate withFormate:(NSInteger)formateType withBlock:(wjsCountDownBlock)block
{
    
    NSTimeInterval fromTimeInterval = [[self stringWithOutTime:fromDate] timeIntervalSince1970];
    NSTimeInterval toTimeInterval = [[self stringWithOutTime:toDate] timeIntervalSince1970];
    if (fromTimeInterval < toTimeInterval) {
        //计算两者的时间差
        countTime = toTimeInterval - fromTimeInterval;
        if (formateType > 4) {
            dateFormat = 0;
        }else{
            dateFormat = formateType;
        }
        self.countDownblock = block;
        //设置时间
        [self calculateTimeString];
        //初始化计时器
        [self initNSTimer];
    }else{
        self.text = @"开始时间大于结束时间无法倒计时";
    }
}


#pragma mark - 根据传入的与1970-01-01 00:00:00的时间戳差计算时间，取年月日等
- (void)calculateTimeString
{
    //倒计时结束时间 以1970-01-01 00:00:00为基准
    NSDate * endTime = [NSDate dateWithTimeIntervalSince1970:countTime];
    //初始化1970-01-01 00:00:00时间
    NSDate * startTime = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    
    //获取时间的各个部分
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:startTime  toDate:endTime  options:0];
    
    //设置label的text
    [self setTimeString:cps];
}

#pragma mark - 根据格式设置时间
- (void)setTimeString:(NSDateComponents *)cps
{
    //提取秒，分，时，天，月，年
    NSInteger diffSec = [cps second];
    NSInteger diffMin = [cps minute];
    NSInteger diffHour = [cps hour];
    NSInteger diffDay = [cps day];
    NSInteger diffMon = [cps month];
    NSInteger diffYear = [cps year];
    NSString * stringTime;
    
    if(dateFormat == formateWithSecMin){
        //根据时间戳秒数算分钟数
        NSInteger min = countTime / 60;
        if (diffSec < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld",diffSec];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld",diffSec];
        }
        if (min < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld:%@", min,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld:%@", min,stringTime];
        }
    }else if (dateFormat == formateWithSecMinHour){
        //根据时间戳秒数算小时数
        NSInteger hour = countTime / 3600;
        if (diffSec < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld",diffSec];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld",diffSec];
        }
        if (diffMin < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld:%@", diffMin,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld:%@", diffMin,stringTime];
        }
        if (hour < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld:%@",hour,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld:%@",hour,stringTime];
        }
    }else if (dateFormat == formateWithSecMinHourDay){
        //根据时间戳秒数算天数
        NSInteger day = countTime / 86400;
        if (diffSec < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld秒",diffSec];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld秒",diffSec];
        }
        if (diffMin < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld分%@", diffMin,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld分%@", diffMin,stringTime];
        }
        if (diffHour < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld小时%@",diffHour,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld小时%@",diffHour,stringTime];
        }
        stringTime = [NSString stringWithFormat:@"%ld天%@",day,stringTime];
    }else if (dateFormat == formateWithSecMinHourDayMon){
        //根据年数算月数
        NSInteger mon = diffYear * 12 + diffMon;
        if (diffSec < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld秒",diffSec];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld秒",diffSec];
        }
        if (diffMin < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld分%@", diffMin,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld分%@", diffMin,stringTime];
        }
        if (diffHour < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld小时%@",diffHour,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld小时%@",diffHour,stringTime];
        }
        stringTime = [NSString stringWithFormat:@"%ld月%ld天%@",mon,diffDay,stringTime];
    }else if (dateFormat == formateWithSecMinHourDayMonYear){
        if (diffSec < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld秒",diffSec];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld秒",diffSec];
        }
        if (diffMin < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld分%@", diffMin,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld分%@", diffMin,stringTime];
        }
        if (diffHour < 10) {
            stringTime = [NSString stringWithFormat:@"0%ld小时%@",diffHour,stringTime];
        }else{
            stringTime = [NSString stringWithFormat:@"%ld小时%@",diffHour,stringTime];
        }
        stringTime = [NSString stringWithFormat:@"%ld年%ld月%ld天%@",diffYear,diffMon,diffDay,stringTime];
    }
    
    self.text = stringTime;
}

#pragma mark ----------------- 定时器代码块
#pragma mark - 初始化定时器
- (void)initNSTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    [self timerStart];
}

#pragma mark - 定时器启动
- (void)timerStart
{
    [timer fire];
}

#pragma mark - 定时器结束
- (void)timerStop
{
    [timer invalidate];
}

#pragma mark - 定时器每秒执行方法
- (void)timerChange
{
    if (countTime > 0) {
        countTime--;
        [self calculateTimeString];
        [self.delegate wjsCountDownProgress:self state:countDownGoing timeStamp:countTime];
        //如果block不为空，则执行block
        if (self.countDownblock) {
            self.countDownblock(self, countDownGoing, countTime);
        }
    }else{
        [timer invalidate];
        [self.delegate wjsCountDownProgress:self state:countDownFinish timeStamp:countTime];
        //如果block不为空，则执行block
        if (self.countDownblock) {
            self.countDownblock(self, countDownFinish, countTime);
        }
    }
}

#pragma mark - 根据格式将NSString转化成NSDate
- (NSDate *)stringWithTime:(NSString *)stringTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:stringTime];
}

- (NSDate *)stringWithOutTime:(NSString *)stringTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:stringTime];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
