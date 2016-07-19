//
//  Contants.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#ifndef Contants_h
#define Contants_h

//推荐页面url
#define RecommendUrl @"http://www.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=appindex&version=4.0.2&apitime=1468322159&sign=eeb225b9fcbc96be59c8799957d08a67"

// 活动界面url
#define HigtEnerRequest_Url @"http://www.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=comicactive&version=4.0.2&apitime=1468372216&sign=93bde57b31660948bace332dd92f2b8e"

//排行界面url
#define RankListRequest_Url @"http://www.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=monthrank&apitime=1468372613&version=4.0.2&sign=85f7bfe055953d74db481f5b11bee866"

//点击cell 请求分集数url
#define DiversityRequest_Url(Time,ID) [NSString stringWithFormat:@"http://www.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=comicinfo&version=4.0.2&apitime=%@&comic_id=%@&uid=0&sign=270c837fcbd8d8c2b9430e51468ba5f9",Time,ID]


//点击cell 请求评论 url
#define CommentRequest_Url(ID) [NSString stringWithFormat:@"http://www.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=comiccomment&version=4.0.2&apitime=1468377072&comicid=%@&uid=0&page_num=0&sign=912c34d57cfd9677af76756dd43619a4",ID]



//点击具体cell  请求漫画图片 url
#define RequestImage_Url(ID,pager_idx) [NSString stringWithFormat:@"http://r.comicq.cn/comic.php?m=QmAndroidV4x&from_os=ios&a=comiccontent&version=4.0.2&apitime=1468378284&comicid=%@&orderidx=%@&uid=0&sign=0b04c0cb2568d1c7371a5611452f55cb",ID,pager_idx]









#endif /* Contants_h */
