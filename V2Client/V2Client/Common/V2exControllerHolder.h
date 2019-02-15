//
//  V2exControllerHolder.h
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDrawerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface V2exControllerHolder : NSObject

@property (strong, nonatomic, nullable) MMDrawerController      *drawerController;
@property (strong, nonatomic, nullable) UINavigationController  *centerViewController;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
