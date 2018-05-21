//
//  HotLiveModel.h
//  YJLCopyTV
//
//  Created by qianfeng on 16/8/4.
//  Copyright © 2016年 yangjianliang. All rights reserved.
//

#import "JSONModel.h"

@interface HotLiveModel : JSONModel
/**
 *  热门
 *
 *  @param nonatomic <#nonatomic description#>
 *  @param strong    <#strong description#>
 *
 *  @return <#return value description#>
 */
//"allnum": 10340,
@property (nonatomic ,strong)NSNumber<Optional> *allnum;
//"roomid": 30397,
@property (nonatomic ,strong)NSNumber<Optional> *roomid;
//"serverid": 6,
@property (nonatomic ,strong)NSNumber<Optional> *serverid;
//"gps": "烟台市",
@property (nonatomic,copy)NSString<Optional> *gps;
//"flv": "http://hdl.9158.com/live/6fe795f5fcfa22e20e1b23b28ac6a968.flv",
@property (nonatomic,copy)NSString<Optional> *flv;

//"starlevel": 3,
@property (nonatomic ,strong)NSNumber<Optional> *starlevel;

//"useridx": 7321,
@property (nonatomic ,strong)NSNumber<Optional> *useridx;
//"userId": "WeiXin18592646",
@property (nonatomic,copy)NSString<Optional> *userId;
//"gender": 0,
@property (nonatomic ,strong)NSNumber<Optional> *gender;
//"myname": "凤舞💋刘宝宝",
@property (nonatomic,copy)NSString<Optional> *myname;
//"signatures": "爱我先关注我～微博：刘y宝宝",
@property (nonatomic,copy)NSString<Optional> *signatures;
//"smallpic": "http://liveimg.9158.com/pic/avator/2016-07/17/23/20160717233237_7321_250.png",
@property (nonatomic,copy)NSString<Optional> *smallpic;
//"bigpic": "http://liveimg.9158.com/pic/avator/2016-07/17/23/20160717233237_7321_640.png",
@property (nonatomic,copy)NSString<Optional> *bigpic;
//"level": 0,
@property (nonatomic ,strong)NSNumber<Optional> *level;
//"grade": 0,
@property (nonatomic ,strong)NSNumber<Optional> *grade;
//"curexp": 0
@property (nonatomic ,strong)NSNumber<Optional> *curexp;

/**
 *  最近
 */
@property(nonatomic,strong)NSString<Optional>*position;
@property(nonatomic,strong)NSString<Optional>*photo;
@property(nonatomic,strong)NSString<Optional>*nickname;
@end
