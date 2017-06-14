//
//  ShoperPhotoDetailView.h
//  ETravel
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoperPhotoDetailView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) UICollectionView * myCollectionView;
@property (nonatomic,strong) UIScrollView * myScrollView;
@property (nonatomic,strong) UILabel * topLable;//顶部页数label

@property (nonatomic,strong) void (^closeBlock)();

//从商家相册跳到图片详情的设置
-(void)picJump:(NSInteger)section row:(NSInteger)row;

@end
