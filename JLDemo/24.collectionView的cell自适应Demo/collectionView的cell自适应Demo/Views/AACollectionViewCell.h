//
//  AACollectionViewCell.h
//  collectionView的cell自适应Demo
//
//  Created by 杨建亮 on 2018/5/16.
//  Copyright © 2018年 yangjianliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLTextView.h"

@interface AACollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet JLTextView *jltextView;

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end
