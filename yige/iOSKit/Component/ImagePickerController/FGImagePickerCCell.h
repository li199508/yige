//
//  FGImagePickerCCell.h
//  yiquanqiu
//
//  Created by Eric on 2017/7/24.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGImagePickerCCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;

@end
