//
//  ShoperPhotoDetailView.m
//  ETravel
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "ShoperPhotoDetailView.h"
#import "ShoperDetailCollectionViewCell.h"
#import "MerchantsCateModel.h"
#import "MctCateModel.h"
#import "UIImageView+WebCache.h"

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

#define normalColor  [UIColor whiteColor]
#define selectedColor  [UIColor blueColor]

static NSString * const kvcell=@"ShoperDetailCollectionViewCell";
static NSString * const kvhead=@"MyCollectionViewHeader";
static float const itemWidth=80;

@implementation ShoperPhotoDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor blackColor];
        
    }
    
    return self;
}

-(void)setDataArray:(NSArray *)dataArray
{
    if (dataArray!=nil) {
        _dataArray=dataArray;
        
        [self creatMainView];//创建主要视图
    }
}

//创建主要视图
-(void)creatMainView
{
    //创建底部滚动视图子控件
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    self.myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight-40) collectionViewLayout:layout];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
    self.myCollectionView.backgroundColor=[UIColor blackColor];
    self.myCollectionView.pagingEnabled=YES;
    [self addSubview:self.myCollectionView];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoperDetailCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kvcell];
    
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, selfHeight-40, DeviceWidth, 40)];
    self.myScrollView.backgroundColor=[UIColor colorWithRed:27/255.0 green:27/255.0 blue:27/255.0 alpha:1];
    self.myScrollView.showsHorizontalScrollIndicator=NO;
    self.myScrollView.delegate=self;
    self.myScrollView.contentSize=CGSizeMake(itemWidth*self.dataArray.count, 40);
    [self addSubview:self.myScrollView];
    
    for (int i=0; i<self.dataArray.count; i++) {
        
        MerchantsCateModel * merchantsCate=self.dataArray[i];
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(itemWidth*i, 0, itemWidth, 40);
        [button setTitle:merchantsCate.album_cate_name forState:UIControlStateNormal];
        [button setTitleColor:normalColor forState:UIControlStateNormal];
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        button.tag=10+i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.myScrollView addSubview:button];
        
        if (i==0) {
            button.selected=YES;
        }
        
    }
    
    self.topLable=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, selfWidth-40, 20)];
    self.topLable.text=@"0/0";
    self.topLable.textColor=[UIColor whiteColor];
    self.topLable.textAlignment=NSTextAlignmentCenter;
    self.topLable.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.topLable];
    
}

//滚动视图按钮点击事件
-(void)buttonClicked:(UIButton *)btn
{
    [self setCurrentButton:btn];
}

//设置当前滚动视图的button
-(void)setCurrentButton:(UIButton *)btn
{
    for (int i=0; i<self.dataArray.count; i++) {
        
        UIButton * button=[self.myScrollView viewWithTag:10+i];
        button.selected=NO;
        
    }
    
    btn.selected=YES;
    
    NSInteger count=[self planFrontCount:btn.tag-10 row:0];
    [self.myCollectionView setContentOffset:CGPointMake(count*selfWidth, 0)];
//    NSLog(@"中心位置%ld",(long)count);
    
    [self setTopLableText:btn.tag-10 row:0];
    
}

//设置顶部lable文字
-(void)setTopLableText:(NSInteger)section row:(NSInteger)row
{
    NSInteger count=[self planFrontCount:section row:row];
    [self.myCollectionView setContentOffset:CGPointMake(count*selfWidth, 0)];
//    NSLog(@"中心位置%ld",(long)count);
    
    MerchantsCateModel * merchants=self.dataArray[section];
//    NSLog(@"列：%ld,行：%ld",(long)section,(long)row);
    self.topLable.text=[NSString stringWithFormat:@"%ld/%lu",(long)row+1,(unsigned long)merchants.album_list.count];
}

//从商家相册跳到图片详情的设置
-(void)picJump:(NSInteger)section row:(NSInteger)row
{
    for (int i=0; i<self.dataArray.count; i++) {
        
        UIButton * button=[self.myScrollView viewWithTag:10+i];
        button.selected=NO;
        
    }
    
    UIButton * btn=[self.myScrollView viewWithTag:10+section];
    btn.selected=YES;
    
    NSInteger count=[self planFrontCount:section row:row];
    [self.myCollectionView setContentOffset:CGPointMake(count*selfWidth, 0)];
//    NSLog(@"中心位置%ld",(long)count);
    
    MerchantsCateModel * merchants=self.dataArray[section];
//    NSLog(@"**列：%ld,行：%ld",(long)section,(long)row);
    self.topLable.text=[NSString stringWithFormat:@"%ld/%lu",(long)row+1,(unsigned long)merchants.album_list.count];
}

//计算偏移量
-(NSInteger)planFrontCount:(NSInteger)section row:(NSInteger)row
{
    NSInteger count=0;
    for (int i=0; i<self.dataArray.count; i++) {
        
        if (i>=section) {
            count+=row;
            break;
        }else{
            MerchantsCateModel * merchantsCate=self.dataArray[i];
            count+=merchantsCate.album_list.count;
        }
        
    }
    
    return count;
}

#pragma mark - scrollView代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==self.myCollectionView) {
        
        if ([self.myCollectionView.visibleCells isKindOfClass:[NSArray class]]) {
            
            ShoperDetailCollectionViewCell * cell=self.myCollectionView.visibleCells[0];
            NSIndexPath * indexPath=[self.myCollectionView indexPathForCell:cell];
            
            [self picJump:indexPath.section row:indexPath.row];
            
        }
        
    }
    
}


#pragma mark - myCollectionView的代理方法

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MerchantsCateModel * merchantsCate=self.dataArray[section];
    return merchantsCate.album_list.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(selfWidth, selfHeight-40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoperDetailCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:kvcell forIndexPath:indexPath];
    cell.backgroundColor=[UIColor blackColor];
    
    MerchantsCateModel * merchantsCate=self.dataArray[indexPath.section];
    MctCateModel * mctCate=merchantsCate.album_list[indexPath.item];
    [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:mctCate.picture] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        cell.picWidth.constant=(selfWidth-10);
        cell.picHeight.constant=(selfWidth-10)*(image.size.height/image.size.width);
        
    }];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.closeBlock();
}

@end
