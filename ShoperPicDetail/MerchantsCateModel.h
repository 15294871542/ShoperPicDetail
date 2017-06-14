//
//  MerchantsCateModel.h
//  ETravel
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantsCateModel : NSObject

//商家相册信息对象字段
@property (nonatomic,strong) NSString * album_cate_id;//分类id
@property (nonatomic,strong) NSString * album_cate_name;//分类名称
@property (nonatomic,strong) NSArray * album_list;//图片数组[二维数组]

@end
