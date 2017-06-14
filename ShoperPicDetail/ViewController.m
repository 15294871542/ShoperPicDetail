//
//  ViewController.m
//  ShoperPicDetail
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "ViewController.h"
#import "ShoperPhotoView.h"
#import "ShoperPhotoDetailView.h"

#import "MJExtension.h"
#import "MerchantsCateModel.h"
#import "MctCateModel.h"

@interface ViewController ()

{
    NSDictionary * dataDic;
}

@end

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatData];//创建一些数据
    [self creatMainView];//创建主要界面
    
}

//创建主要界面
-(void)creatMainView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //model数据
    [MerchantsCateModel mj_setupObjectClassInArray:^NSDictionary *{
        
        return @{@"album_list":@"MctCateModel"};
        
    }];
    NSArray * array=[MerchantsCateModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"album_data"]];
    
    //商家相册
    ShoperPhotoView * shoperPhoto=[[ShoperPhotoView alloc]initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-70)];
    shoperPhoto.minWidth=60;
    shoperPhoto.dataArray=array;
    [self.view addSubview:shoperPhoto];
    
    //商家相册详情
    UIWindow * window=[UIApplication sharedApplication].delegate.window;
    ShoperPhotoDetailView * shoperPhotoDetail=[[ShoperPhotoDetailView alloc]initWithFrame:CGRectMake(DeviceWidth, 0, DeviceWidth, window.frame.size.height)];
    shoperPhotoDetail.dataArray=array;
//    [window addSubview:shoperPhotoDetail];//使用导航则添加到window上
    [self.view addSubview:shoperPhotoDetail];
    
    //图片点击事件
    shoperPhoto.picClicked = ^(NSInteger section, NSInteger row){
        
        [shoperPhotoDetail picJump:section row:row];
        shoperPhotoDetail.frame=CGRectMake(0, 0, DeviceWidth, window.frame.size.height);
        
    };
    
    __weak typeof (shoperPhotoDetail) weakSelf =shoperPhotoDetail;
    shoperPhotoDetail.closeBlock = ^{
        weakSelf.frame=CGRectMake(DeviceWidth, 0, DeviceWidth, window.frame.size.height);
    };
}

//创建一些数据
-(void)creatData
{
    dataDic=
  @{@"album_data" : @[
    @{
        @"album_cate_id" : @"1",
        @"album_list" : @[
        @{
            @"album_cate_id" : @"1",
            @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498017039&di=3cb0f55b4c491739bb960fa00aefd1bd&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.1tong.com%2Fuploads%2Fwallpaper%2Flandscapes%2F273-1-1920x1200.jpg",
            @"album_id" : @"2"
        },
        @{
            @"album_cate_id" : @"1",
            @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422320616&di=91e37678bebe75ef2a3fb86332c13de5&imgtype=0&src=http%3A%2F%2Fh8.86.cc%2Fwalls%2F20160302%2F1440x900_051b44f7f94f775.jpg",
            @"album_id" : @"3"
        }
                      ],
        @"album_cate_name" : @"小清新"
    },
    @{
        @"album_cate_id" : @"2",
        @"album_list" : @[
        @{
            @"album_cate_id" : @"2",
            @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498017081&di=1a5f2c9281bf6f1d8f4b740ac1362afa&imgtype=jpg&er=1&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F1f178a82b9014a90e7eb9d17ac773912b21bee47.jpg",
            @"album_id" : @"4"
        },
        @{
            @"album_cate_id" : @"2",
            @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422362587&di=4a58097f92a67bbbbaaf1ff22e386a83&imgtype=0&src=http%3A%2F%2Fpic67.nipic.com%2Ffile%2F20150514%2F21036787_181947848862_2.jpg",
            @"album_id" : @"5"
        },
        @{
            @"album_cate_id" : @"2",
            @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422362586&di=74a27b2abf681912d16f40267c1bb5e7&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F1f178a82b9014a909461e9baa1773912b31bee5e.jpg",
            @"album_id" : @"6"
        }
                      ],
        @"album_cate_name" : @"高清动漫"
        },
    @{
        @"album_cate_id" : @"3",
        @"album_list" : @[
                @{
                    @"album_cate_id" : @"3",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422429641&di=a03a8213015917a3a96a52a98f948a35&imgtype=0&src=http%3A%2F%2Fandroid-wallpapers.25pp.com%2Ffs01%2F2014%2F09%2F30%2F0_3675c5ca51a2f5fec8f756217ea66dd6_900x675.jpg",
                    @"album_id" : @"7"
                    },
                @{
                    @"album_cate_id" : @"3",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422429641&di=69056337066b681fe6d8c2cc7a1b0c79&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201601%2F28%2F20160128213701_xuhif.gif",
                    @"album_id" : @"8"
                    },
                @{
                    @"album_cate_id" : @"3",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422429640&di=f3531245b4b4714a5091bef9cb3510f6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2Ff6d1ad6c709f0030cb77b51664c0b1da.jpg",
                    @"album_id" : @"9"
                    },
                @{
                    @"album_cate_id" : @"3",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422429640&di=dbddd9925ceacab1ac1e438c94affd8c&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F94%2F09%2F76b58PICr5M_1024.jpg",
                    @"album_id" : @"10"
                    }
                ],
        @"album_cate_name" : @"星空"
        },
    @{
        @"album_cate_id" : @"4",
        @"album_list" : @[
                @{
                    @"album_cate_id" : @"4",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422590778&di=6cbece0a29eb961053f6c991b0f752d6&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170113%2F731fcff9b0a746d18c1b858b2ad722a5_th.jpeg",
                    @"album_id" : @"11"
                    },
                @{
                    @"album_cate_id" : @"4",
                    @"picture" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422611245&di=01dc2612bbc20ccb6dcb2985838661cb&imgtype=jpg&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fcaef76094b36acaf6d788f347bd98d1000e99c59.jpg",
                    @"album_id" : @"12"
                    }
                ],
        @"album_cate_name" : @"帅哥"
        }
    
                            ]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
