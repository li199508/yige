//
//  DDAlertView.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/9.
//

#import "DDAlertView.h"
@interface DDAlertView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *messageLable;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *certainBtn;

@property (nonatomic, strong) NSArray *btnNames;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@end

@implementation DDAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message btnNames:(NSArray *)btnNames
{
    if (self = [super init]) {
        
        _title = title;
        _message = message;
        _btnNames = btnNames;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void)setupViews
{
    self.containerView = [UIView new];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.clipsToBounds = YES;
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containerView];
    
    self.titleLable = [UILabel new];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.textColor = UIColorFromHex(0x333333);
    self.titleLable.font = AdaptedFontSize(19);
    self.titleLable.text = self.title;
    [self.containerView addSubview:self.titleLable];
    
    self.messageLable = [UILabel new];
    self.messageLable.textColor = UIColorFromHex(0x333333);
    self.messageLable.font = AdaptedFontSize(17);
    self.messageLable.numberOfLines = 0;
    self.messageLable.textAlignment = NSTextAlignmentCenter;
    self.messageLable.text = self.message;
    [self.containerView addSubview:self.messageLable];
    
    if (self.btnNames.count > 1) {
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitle:self.btnNames.firstObject forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = AdaptedFontSize(19);
        [self.containerView addSubview:self.cancelBtn];
    }
    
    self.certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.certainBtn addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    [self.certainBtn setTitle:self.btnNames.lastObject forState:UIControlStateNormal];
    [self.certainBtn setTitleColor:UIColorFromHex(0x288cf0) forState:UIControlStateNormal];
    self.certainBtn.titleLabel.font =AdaptedFontSize(19);
    [self.containerView addSubview:self.certainBtn];
    
}

- (void)setupLayout
{
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(AdaptedWidth(48));
        make.right.equalTo(self).offset(AdaptedWidth(-48));
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(AdaptedWidth(22));
        make.centerX.equalTo(self.containerView.mas_centerX);
    }];
    
    [self.messageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(AdaptedWidth(20));
        make.right.equalTo(self.containerView).offset(AdaptedWidth(-20));
        make.top.equalTo(self.titleLable.mas_bottom).offset(AdaptedWidth(22));
    }];
    
    
    if (self.btnNames.count > 1) {
        [self.cancelBtn addTopLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(20), 0, 0)];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView.mas_left).offset(0);
            make.right.equalTo(self.containerView.mas_centerX).offset(AdaptedWidth(0));
            make.top.equalTo(self.messageLable.mas_bottom).offset(AdaptedWidth(30));
            make.height.mas_equalTo(AdaptedWidth(60));
        }];
        
        [self.certainBtn addTopLineWithEdge:UIEdgeInsetsMake(0, 0, 0, AdaptedWidth(20))];
        [self.certainBtn addLeftLineWithEdge:UIEdgeInsetsMake(AdaptedWidth(10), 0, AdaptedWidth(10), 0)];
        [self.certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView.mas_centerX).offset(AdaptedWidth(0));
            make.top.equalTo(self.messageLable.mas_bottom).offset(AdaptedWidth(30));
            make.height.mas_equalTo(AdaptedWidth(60));
            make.right.offset(0);
            make.bottom.equalTo(self.containerView).offset(AdaptedWidth(0));
        }];
    }else{
        [self.certainBtn addTopLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(20), 0, AdaptedWidth(20))];
        [self.certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.containerView.mas_centerX);
            make.top.equalTo(self.messageLable.mas_bottom).offset(AdaptedWidth(30));
            make.height.mas_equalTo(AdaptedWidth(60));
            make.left.equalTo(self.containerView).offset(AdaptedWidth(20));
            make.bottom.equalTo(self.containerView).offset(AdaptedWidth(0));
        }];
    }
}

- (void)cancelAction
{
    if (self.didSelected) {
        self.didSelected(YES);
    }
    [self removeFromSuperview];
}

- (void)certainAction
{
    if (self.didSelected) {
        self.didSelected(NO);
    }
    [self removeFromSuperview];
}

- (void)show
{
    [kKeyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kKeyWindow);
    }];
    
    CAAnimation *showsAnimation = [self defaultShowsAnimation];
    [self.containerView.layer addAnimation:showsAnimation forKey:@"Popup"];
}


#pragma mark- Show Animations
#define transformScale(scale) [NSValue valueWithCATransform3D:[self transform3DScale:scale]]

- (CATransform3D)transform3DScale:(CGFloat)scale
{
    // Add scale on current transform.
    CATransform3D currentTransfrom = CATransform3DScale(self.layer.transform, scale, scale, 1.0f);
    
    return currentTransfrom;
}

- (CAAnimation *)defaultShowsAnimation
{
    NSArray *frameValues = @[transformScale(0.1f), transformScale(1.15f), transformScale(0.9f), transformScale(1.0f)];
    NSArray *frameTimes = @[@(0.0f), @(0.5f), @(0.9f), @(1.0f)];
    return [self animationWithValues:frameValues times:frameTimes duration:0.3f];
}

- (CAKeyframeAnimation *)animationWithValues:(NSArray*)values times:(NSArray*)times duration:(CGFloat)duration {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [animation setValues:values];
    [animation setKeyTimes:times];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setRemovedOnCompletion:NO];
    [animation setDuration:duration];
    
    return animation;
}

@end
