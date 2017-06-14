//
//  MctCateModel.h
//  ETravel
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MctCateModel : NSObject

//商家相册信息对象字段(图片数组)
@property (nonatomic,strong) NSString * album_id;//图片id
@property (nonatomic,strong) NSString * album_cate_id;//分类名称
@property (nonatomic,strong) NSString * picture;//图片路径

@end
